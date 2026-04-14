#!/usr/bin/env bash
# xp/return-format.sh — PostToolUse hook (INJECTION-on-violation)
#
# Validates that sub-agent returns follow the Finding + Sources contract.
# When a Task/Agent return lacks the required structure, prepends a warning
# so the parent re-dispatches with a corrected contract.
#
# Active only in /xp projects (docs/xp/ present). Non-/xp projects silent.
#
# Output: stdout (warning) on violation; silent on conformance. Exit 0.

set -uo pipefail

INPUT=$(cat)
# VS Code provides cwd in JSON input; fall back to pwd for Claude Code
CWD=$(printf '%s' "$INPUT" | python3 -c 'import sys,json; d=json.load(sys.stdin); print(d.get("cwd",""))' 2>/dev/null || true)
[ -n "$CWD" ] || CWD=$(pwd)
[ -d "$CWD/docs/xp" ] || exit 0

if ! command -v python3 >/dev/null 2>&1; then
    exit 0
fi

# Parse with python via env var (heredoc takes stdin, so pipe doesn't work)
PARSED=$(XP_INPUT="$INPUT" python3 -c '
import sys, json, os
raw = os.environ.get("XP_INPUT", "")
try:
    d = json.loads(raw)
except Exception:
    sys.exit(0)
tn = d.get("tool_name", "")
tr = d.get("tool_response", "") or d.get("tool_result", "")
if isinstance(tr, dict):
    parts = tr.get("content", [])
    if isinstance(parts, list):
        tr = "\n".join(p.get("text","") for p in parts if isinstance(p, dict) and p.get("type")=="text")
    else:
        tr = json.dumps(tr)
elif not isinstance(tr, str):
    tr = str(tr)
# tab-separated: tool_name<TAB>response (truncated)
print(tn + "\t" + tr[:8000].replace("\t"," ").replace("\n","\\n"))
' 2>/dev/null) || exit 0

TOOL_NAME=$(printf '%s' "$PARSED" | cut -f1)
RESPONSE=$(printf '%s' "$PARSED" | cut -f2- | sed 's/\\n/\n/g')

# VS Code uses runSubagent; Claude Code uses Task/Agent
case "$TOOL_NAME" in
    Task|Agent|runSubagent) ;;
    *) exit 0 ;;
esac

[ -n "$RESPONSE" ] || exit 0

WORDS=$(printf '%s' "$RESPONSE" | wc -w | tr -d ' ')
if [ "$WORDS" -lt 30 ]; then
    exit 0
fi

HAS_FINDING=0
HAS_SOURCES=0
printf '%s' "$RESPONSE" | grep -qiE '(^|\n)[[:space:]]*finding[s]?[[:space:]]*[:|=]' && HAS_FINDING=1
printf '%s' "$RESPONSE" | grep -qiE '(^|\n)[[:space:]]*sources?[[:space:]]*[:|=]' && HAS_SOURCES=1

if [ "$HAS_FINDING" = "1" ] && [ "$HAS_SOURCES" = "1" ]; then
    exit 0
fi

MISSING=""
[ "$HAS_FINDING" = "0" ] && MISSING="Finding section"
if [ "$HAS_SOURCES" = "0" ]; then
    [ -n "$MISSING" ] && MISSING="$MISSING and Sources section" || MISSING="Sources section"
fi

cat <<EOF
[/xp return-format — sub-agent return does NOT match required contract]

Per Sub-Agent System Prompt Contract, every sub-agent return MUST be:
  Finding: <≤5 bullets, one fact each>
  Sources: <file:line for each finding>

The last Task/Agent return is missing $MISSING.

Do NOT absorb a malformed finding into your synthesis. Re-dispatch the
sub-agent with the contract explicit in its prompt:

  Role: <one-sentence task>
  Non-role: "Do not decide. Do not recommend. Do not conclude."
  Return format: "Finding: <≤5 bullets>\nSources: <file:line>"
  Tools: <explicit allowlist>
EOF
exit 0
