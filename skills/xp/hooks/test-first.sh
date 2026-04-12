#!/usr/bin/env bash
# xp/test-first.sh — PreToolUse hook for Write/Edit
#
# Enforces Phase 06 Iron Law: NO PRODUCTION CODE WITHOUT A FAILING TEST FIRST.
# Blocks Write/Edit to non-test source paths unless a test file was touched
# in the recent session history.
#
# Safety: activates only in /xp projects (docs/xp/ directory present).
#         Non-/xp projects are unaffected.
#
# Exit codes:
#   0 — allow (not applicable, or check passed)
#   2 — block, surface stderr to agent for re-engagement

set -euo pipefail

INPUT=$(cat)

# Only activate in /xp projects
if [ ! -d "$(pwd)/docs/xp" ]; then
    exit 0
fi

# Parse tool_name and tool_input.file_path from the JSON
TOOL_NAME=""
FILE_PATH=""
TRANSCRIPT_PATH=""

if command -v python3 >/dev/null 2>&1; then
    read -r TOOL_NAME FILE_PATH TRANSCRIPT_PATH < <(printf '%s' "$INPUT" | python3 -c '
import sys, json
d = json.load(sys.stdin)
tn = d.get("tool_name", "")
fp = d.get("tool_input", {}).get("file_path", "")
tp = d.get("transcript_path", "")
print(tn, fp, tp)
' 2>/dev/null || printf '\n')
fi

# Only fire on Write/Edit
case "$TOOL_NAME" in
    Write|Edit|MultiEdit) ;;
    *) exit 0 ;;
esac

# Skip if no file path
[ -n "$FILE_PATH" ] || exit 0

# Skip if the write IS itself a test file (we're allowing test writes)
case "$FILE_PATH" in
    */test/*|*/tests/*|*/spec/*|*/__tests__/*|*_test.*|*.test.*|*.spec.*|*_spec.*|*Test.*|*Spec.*)
        exit 0 ;;
esac

# Skip non-source paths (docs, configs, hooks themselves, etc.)
case "$FILE_PATH" in
    */docs/*|*/hooks/*|*.md|*.json|*.yaml|*.yml|*.toml|*.lock|*.config.*|.gitignore|.dockerignore|Dockerfile|Makefile)
        exit 0 ;;
esac

# Only gate clearly-source paths
case "$FILE_PATH" in
    */src/*|*/lib/*|*/app/*|*/pkg/*|*/internal/*|*/cmd/*) ;;
    *) exit 0 ;;
esac

# Check transcript for recent test file touches (last ~40 tool events)
RECENT_TEST_TOUCH=0
if [ -n "$TRANSCRIPT_PATH" ] && [ -f "$TRANSCRIPT_PATH" ] && command -v python3 >/dev/null 2>&1; then
    RECENT_TEST_TOUCH=$(python3 - "$TRANSCRIPT_PATH" <<'PY' 2>/dev/null || printf '0'
import sys, json, re

path = sys.argv[1]
test_pat = re.compile(r'(/test/|/tests/|/spec/|/__tests__/|_test\.|\.test\.|\.spec\.|_spec\.|Test\.|Spec\.)')
write_tools = {"Write", "Edit", "MultiEdit"}

try:
    with open(path, "r") as f:
        lines = f.readlines()
except Exception:
    print("0"); sys.exit()

# Scan last 80 lines (roughly last ~40 tool events)
for line in reversed(lines[-80:]):
    try:
        evt = json.loads(line)
    except Exception:
        continue
    msg = evt.get("message", {})
    if not isinstance(msg, dict):
        continue
    content = msg.get("content", [])
    if not isinstance(content, list):
        continue
    for block in content:
        if not isinstance(block, dict):
            continue
        if block.get("type") == "tool_use":
            name = block.get("name", "")
            if name in write_tools:
                fp = block.get("input", {}).get("file_path", "")
                if fp and test_pat.search(fp):
                    print("1"); sys.exit()
print("0")
PY
)
fi

if [ "$RECENT_TEST_TOUCH" = "1" ]; then
    exit 0
fi

# Block — no recent test file touched
cat >&2 <<EOF
BLOCKED by /xp test-first hook (Phase 06 Iron Law).

Attempted write: $FILE_PATH

No test file was written or edited in the recent session. The Iron Law is:

    NO PRODUCTION CODE WITHOUT A FAILING TEST FIRST.

Fix the underlying violation — do NOT work around this hook:

  1. Write (or edit) a test that fails for the behavior you're about to implement.
  2. Confirm it fails (run the test).
  3. Then implement the minimum code to make it pass.

If you believe this file shouldn't be gated (e.g., it's config, types, or
scaffolding), either (a) move it out of src/ / lib/ / app/ / pkg/ /
internal/ / cmd/, or (b) write a token-level test that pins its shape.

Do not disable this hook.
EOF
exit 2
