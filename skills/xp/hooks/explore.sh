#!/usr/bin/env bash
# xp/explore.sh — PreToolUse hook (GATE)
#
# Enforces DELEGATION IRON LAW: exploration tools belong to sub-agents.
# Blocks Grep/Glob/WebFetch/WebSearch in the main agent context. Read is
# NOT blocked (Edit/Write require it; can't be cleanly enforced).
#
# Active only in /xp projects (docs/xp/ present). Sub-agent tool uses
# pass through (this hook only fires for the main agent).
#
# Exit codes: 0 allow, 2 block.

set -uo pipefail

INPUT=$(cat)
[ -d "$(pwd)/docs/xp" ] || exit 0

if ! command -v python3 >/dev/null 2>&1; then
    exit 0
fi

TOOL_NAME=$(XP_INPUT="$INPUT" python3 -c '
import sys, json, os
try:
    d = json.loads(os.environ.get("XP_INPUT", ""))
except Exception:
    sys.exit(0)
print(d.get("tool_name", ""))
' 2>/dev/null) || exit 0

case "$TOOL_NAME" in
    Grep|Glob|WebFetch|WebSearch) ;;
    *) exit 0 ;;
esac

cat >&2 <<EOF
BLOCKED by /xp explore hook (DELEGATION IRON LAW).

$TOOL_NAME is an exploration tool. Per /xp, exploration belongs to
sub-agents — main agent orchestrates and synthesizes, it does not
explore. Raw $TOOL_NAME output in the main context degrades every
subsequent decision.

Fix: dispatch a sub-agent with this contract:
  Role: <one-sentence task, e.g. "Locate call sites of X">
  Non-role: "Do not decide. Do not recommend. Do not conclude."
  Tools: $TOOL_NAME (+ Read if needed)
  Return: "Finding: <≤5 bullets> / Sources: <file:line>"

The sub-agent's findings come back as a condensed string. The raw
$TOOL_NAME output never reaches the main context.

Do not disable this hook.
EOF
exit 2
