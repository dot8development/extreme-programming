#!/usr/bin/env bash
# xp/hypothesis-first.sh — PreToolUse hook for Write/Edit
#
# Enforces: no production code before a hypothesis is recorded.
# Blocks Write/Edit to source paths if docs/xp/hypothesis-log.md is missing.
#
# Safety: activates only in /xp projects (docs/xp/ directory present).
#
# Exit codes:
#   0 — allow
#   2 — block, surface stderr to agent

set -euo pipefail

INPUT=$(cat)

# Only activate in /xp projects
if [ ! -d "$(pwd)/docs/xp" ]; then
    exit 0
fi

# If the hypothesis log already exists, pass — this hook is satisfied.
if [ -f "$(pwd)/docs/xp/hypothesis-log.md" ]; then
    exit 0
fi

# Parse tool_name and file_path
TOOL_NAME=""
FILE_PATH=""
if command -v python3 >/dev/null 2>&1; then
    read -r TOOL_NAME FILE_PATH < <(printf '%s' "$INPUT" | python3 -c '
import sys, json
d = json.load(sys.stdin)
tn = d.get("tool_name", "")
fp = d.get("tool_input", {}).get("file_path", "")
print(tn, fp)
' 2>/dev/null || printf '\n')
fi

# Only gate Write/Edit
case "$TOOL_NAME" in
    Write|Edit|MultiEdit) ;;
    *) exit 0 ;;
esac

[ -n "$FILE_PATH" ] || exit 0

# Allow writes TO docs/xp/ itself (so the log can be created)
case "$FILE_PATH" in
    */docs/xp/*) exit 0 ;;
esac

# Allow docs, configs, top-level files
case "$FILE_PATH" in
    */docs/*|*.md|*.json|*.yaml|*.yml|*.toml|*.lock|.gitignore|Dockerfile|Makefile)
        exit 0 ;;
esac

# Gate clearly-source paths only
case "$FILE_PATH" in
    */src/*|*/lib/*|*/app/*|*/pkg/*|*/internal/*|*/cmd/*) ;;
    *) exit 0 ;;
esac

cat >&2 <<EOF
BLOCKED by /xp hypothesis-first hook (Phase 02 requirement).

Attempted write: $FILE_PATH

docs/xp/hypothesis-log.md does not exist. /xp requires a recorded
hypothesis before production code is written.

Fix the underlying violation:

  1. Run Phase 02 (Discover) with the human. Ask clarifying questions.
  2. The human frames the hypothesis: "We believe [X] will [Y] for [Z]."
  3. The hypothesis must be falsifiable.
  4. Create docs/xp/hypothesis-log.md and record the first entry.
  5. Then proceed to Explore/Design/Plan/Build.

Do not disable this hook. Do not create an empty or placeholder
hypothesis log just to pass the check — that is a worse violation.
EOF
exit 2
