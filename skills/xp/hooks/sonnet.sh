#!/usr/bin/env bash
# xp/sonnet.sh — PreToolUse hook (GATE) for Task / Agent dispatches
#
# Enforces /xp's Sonnet-minimum rule for sub-agents. Blocks Task/Agent
# dispatches that explicitly request Haiku or omit a model when one is
# settable, with a re-engagement message.
#
# Active only in /xp projects (docs/xp/ present). Non-/xp projects pass.
#
# Exit codes: 0 allow, 2 block.

set -euo pipefail

INPUT=$(cat)

[ -d "$(pwd)/docs/xp" ] || exit 0

TOOL_NAME=""
MODEL=""
SUBAGENT_TYPE=""
if command -v python3 >/dev/null 2>&1; then
    read -r TOOL_NAME MODEL SUBAGENT_TYPE < <(printf '%s' "$INPUT" | python3 -c '
import sys, json
d = json.load(sys.stdin)
ti = d.get("tool_input", {}) or {}
print(d.get("tool_name", ""), ti.get("model", ""), ti.get("subagent_type", ""))
' 2>/dev/null || printf '\n')
fi

# Only gate Task / Agent dispatches
case "$TOOL_NAME" in
    Task|Agent) ;;
    *) exit 0 ;;
esac

# Allow if model is sonnet, opus, or claude-3-5-sonnet/4-* etc.
LOWER=$(printf '%s' "$MODEL" | tr 'A-Z' 'a-z')
case "$LOWER" in
    *sonnet*|*opus*) exit 0 ;;
    *haiku*)
        cat >&2 <<EOF
BLOCKED by /xp sonnet hook.

Task dispatched with model="$MODEL". /xp requires Sonnet-minimum for
sub-agents. Cheap models produce understanding debt — fluent-but-shallow
findings that pollute the parent context.

Fix: set model="sonnet" (or better) on the dispatch. Re-dispatch.
EOF
        exit 2
        ;;
    "")
        # Model unspecified; harness default may be Haiku. Warn but don't
        # block — many harnesses only let model be set on Task, not Agent.
        cat >&2 <<EOF
WARNING from /xp sonnet hook: Task dispatch did not specify model. /xp
requires Sonnet-minimum for sub-agents. If your harness defaults to a
cheaper model, set model="sonnet" explicitly. Allowing this dispatch.
EOF
        exit 0
        ;;
    *)
        # Some other model name — allow (likely Sonnet/Opus variant we don't
        # match; safer than false-positive blocking).
        exit 0
        ;;
esac
