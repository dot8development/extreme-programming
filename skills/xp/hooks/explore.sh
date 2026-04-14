#!/usr/bin/env bash
# xp/explore.sh — PreToolUse hook (GATE)
#
# Enforces DELEGATION IRON LAW: exploration tools belong to sub-agents.
# Blocks:
#   - Grep / Glob / WebFetch / WebSearch (Claude Code)
#   - grep_search / file_search / semantic_search / fetch_webpage (VS Code)
#   - Bash / run_in_terminal commands whose verb-tokens are exploration commands
#     (cat, head, tail, less, more, grep, egrep, fgrep, rg, ag, ack,
#     find, fd, locate, awk, sed, tree, wc, diff, comm, file, xxd,
#     hexdump, jq, yq, git log/diff/show/blame/grep)
# Read is NOT blocked — Edit/Write require it.
#
# Active only in /xp projects (docs/xp/ present).
#
# Exit codes: 0 allow, 2 block.

set -uo pipefail

INPUT=$(cat)
# VS Code provides cwd in JSON input; fall back to pwd for Claude Code
CWD=$(printf '%s' "$INPUT" | python3 -c 'import sys,json; d=json.load(sys.stdin); print(d.get("cwd",""))' 2>/dev/null || true)
[ -n "$CWD" ] || CWD=$(pwd)
[ -d "$CWD/docs/xp" ] || exit 0

if ! command -v python3 >/dev/null 2>&1; then
    exit 0
fi

PARSED=$(XP_INPUT="$INPUT" python3 -c '
import sys, json, os
try:
    d = json.loads(os.environ.get("XP_INPUT", ""))
except Exception:
    sys.exit(0)
ti = d.get("tool_input", {}) or {}
cmd = ti.get("command", "")
print(d.get("tool_name", "") + "\t" + cmd.replace("\t"," ").replace("\n"," "))
' 2>/dev/null) || exit 0

TOOL_NAME=$(printf '%s' "$PARSED" | cut -f1)
COMMAND=$(printf '%s' "$PARSED" | cut -f2-)

# Direct exploration tools — block immediately (Claude Code + VS Code names)
case "$TOOL_NAME" in
    Grep|Glob|WebFetch|WebSearch|grep_search|file_search|semantic_search|fetch_webpage)
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
        ;;
    Bash|run_in_terminal) ;;
    *) exit 0 ;;
esac

# Bash: detect exploration verb tokens in the command
[ -n "$COMMAND" ] || exit 0

# Verbs we consider exploration. Listed once as alternation.
EXPLORE_VERBS='ls|ll|la|lsd|exa|cat|bat|head|tail|less|more|grep|egrep|fgrep|rg|ag|ack|find|fd|locate|awk|sed|tree|wc|diff|comm|file|xxd|hexdump|jq|yq|column|nl|tac|strings|od|stat|du|readlink|realpath|dirname|basename'

# Match any verb when it appears as a command token: at start of line, or
# after a pipeline/sequencing operator (| ; && ||), allowing whitespace.
# Also catch `git` exploration subcommands.
HIT=""
if printf '%s' "$COMMAND" | grep -qE "(^|[[:space:]]*[|;&]+[[:space:]]*)($EXPLORE_VERBS)([[:space:]]|$)"; then
    HIT=$(printf '%s' "$COMMAND" | grep -oE "(^|[|;&][[:space:]]*)($EXPLORE_VERBS)([[:space:]]|$)" | head -1 | grep -oE "($EXPLORE_VERBS)")
elif printf '%s' "$COMMAND" | grep -qE '(^|[|;&][[:space:]]*)git[[:space:]]+(log|diff|show|blame|grep)([[:space:]]|$)'; then
    HIT="git $(printf '%s' "$COMMAND" | grep -oE 'git[[:space:]]+(log|diff|show|blame|grep)' | head -1 | awk '{print $2}')"
fi

if [ -z "$HIT" ]; then
    exit 0
fi

cat >&2 <<EOF
BLOCKED by /xp explore hook (DELEGATION IRON LAW).

The Bash command uses '$HIT' — an exploration command. /xp blocks Bash
exploration in the main agent for the same reason it blocks Grep / Glob /
WebFetch: raw output in the main context degrades every subsequent
decision. Bash isn't an escape hatch.

Command: $COMMAND

Fix one of two ways:

  1. Dispatch a sub-agent that runs the inspection with this contract:
       Role: <one-sentence task>
       Non-role: "Do not decide. Do not recommend. Do not conclude."
       Tools: Bash (+ Read if needed)
       Return: "Finding: <≤5 bullets> / Sources: <file:line>"

  2. If the command is genuinely required in the main agent (e.g. starting
     a long-running process you need to interact with), restructure: use
     the Read tool for file inspection, or move the inspection step into
     a sub-agent.

Do not disable this hook.
EOF
exit 2
