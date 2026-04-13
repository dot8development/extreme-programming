#!/usr/bin/env bash
# xp/delegate.sh — PreToolUse hook (GATE)
#
# Enforces DELEGATION IRON LAW: 3+ consecutive Grep/Read calls in the main
# agent context must be delegated to a sub-agent. Counts consecutive same-
# tool-class calls in the recent transcript; blocks the 3rd with a DELEGATE
# instruction.
#
# Active only in /xp projects (docs/xp/ present). Non-/xp projects pass.
#
# Exit codes: 0 allow, 2 block.

set -euo pipefail

INPUT=$(cat)

# Activate only in /xp projects
[ -d "$(pwd)/docs/xp" ] || exit 0

TOOL_NAME=""
TRANSCRIPT_PATH=""
if command -v python3 >/dev/null 2>&1; then
    read -r TOOL_NAME TRANSCRIPT_PATH < <(printf '%s' "$INPUT" | python3 -c '
import sys, json
d = json.load(sys.stdin)
print(d.get("tool_name", ""), d.get("transcript_path", ""))
' 2>/dev/null || printf '\n')
fi

# Only gate exploration tools
case "$TOOL_NAME" in
    Grep|Read|Glob) ;;
    *) exit 0 ;;
esac

# Count consecutive Grep/Read/Glob calls by the MAIN agent (not sub-agents)
# in the most recent ~80 transcript lines. Reset count on any non-exploration
# tool use or any Agent dispatch.
CONSECUTIVE=0
if [ -n "$TRANSCRIPT_PATH" ] && [ -f "$TRANSCRIPT_PATH" ] && command -v python3 >/dev/null 2>&1; then
    CONSECUTIVE=$(python3 - "$TRANSCRIPT_PATH" <<'PY' 2>/dev/null || printf '0'
import sys, json

path = sys.argv[1]
explore = {"Grep", "Read", "Glob"}

try:
    with open(path) as f:
        lines = f.readlines()
except Exception:
    print("0"); sys.exit()

count = 0
# Walk from most recent backward; stop on non-exploration tool use
for line in reversed(lines[-160:]):
    try:
        evt = json.loads(line)
    except Exception:
        continue
    msg = evt.get("message", {})
    if not isinstance(msg, dict):
        continue
    # Only consider main-agent tool uses (no parent_tool_use_id means top-level)
    if evt.get("parentUuid") and evt.get("isSidechain"):
        continue
    content = msg.get("content", [])
    if not isinstance(content, list):
        continue
    for block in content:
        if not isinstance(block, dict) or block.get("type") != "tool_use":
            continue
        name = block.get("name", "")
        if name in explore:
            count += 1
        else:
            # Any non-exploration tool resets the streak
            print(count); sys.exit()
print(count)
PY
)
fi

# This call would be the (CONSECUTIVE + 1)-th. Block when about to hit 3.
if [ "${CONSECUTIVE:-0}" -ge 2 ]; then
    cat >&2 <<EOF
BLOCKED by /xp delegate hook (DELEGATION IRON LAW).

You are about to make your 3rd consecutive Grep/Read/Glob call in the main
agent context. The skill REQUIRES delegation at 3+ consecutive exploration
hops.

Fix the underlying violation:
  1. Stop exploring directly.
  2. Dispatch a sub-agent with: role (one task), non-role ("Do not decide.
     Do not recommend. Do not conclude."), return format (Finding +
     Sources file:line), tools (Grep/Read/Glob).
  3. Synthesize the sub-agent's findings; do not re-explore the same ground.

Do not disable this hook. Delegate.
EOF
    exit 2
fi

exit 0
