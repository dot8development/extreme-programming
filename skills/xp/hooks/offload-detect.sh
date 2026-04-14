#!/usr/bin/env bash
# xp/offload-detect.sh — UserPromptSubmit hook (INJECTION)
#
# Scans the user's prompt for offload patterns (explicit, passive, trust,
# authority, permission, bundled). When detected, prepends a warning to
# context so the model treats the message as Strike-1-triggering instead
# of continuing discovery.
#
# Active only in /xp projects (docs/xp/ present). Non-/xp projects silent.
#
# Output: stdout when offload detected; silent otherwise. Exit 0 always.

set -euo pipefail

INPUT=$(cat)
# VS Code provides cwd in JSON input; fall back to pwd for Claude Code
CWD=$(printf '%s' "$INPUT" | python3 -c 'import sys,json; d=json.load(sys.stdin); print(d.get("cwd",""))' 2>/dev/null || true)
[ -n "$CWD" ] || CWD=$(pwd)
[ -d "$CWD/docs/xp" ] || exit 0

PROMPT=""
if command -v python3 >/dev/null 2>&1; then
    PROMPT=$(printf '%s' "$INPUT" | python3 -c 'import sys,json; d=json.load(sys.stdin); print(d.get("prompt",""))' 2>/dev/null || printf '')
fi

[ -n "$PROMPT" ] || exit 0

# Lower-case for matching; preserve original for display
LOWER=$(printf '%s' "$PROMPT" | tr 'A-Z' 'a-z')

DETECTED=""
CATEGORY=""

# Explicit
if printf '%s' "$LOWER" | grep -qE 'you decide|you pick|you choose|just choose|you frame it'; then
    DETECTED=1; CATEGORY="explicit"
# Trust
elif printf '%s' "$LOWER" | grep -qE 'i trust you|use your judgment|you know best|go with your gut|trust your judgment'; then
    DETECTED=1; CATEGORY="trust"
# Authority
elif printf '%s' "$LOWER" | grep -qE "you'?re the expert|you'?ve read|you'?re closer to|your reasoning is better|you know more"; then
    DETECTED=1; CATEGORY="authority"
# Permission
elif printf '%s' "$LOWER" | grep -qE 'i (give you |am giving you )?(explicit )?permission|i authorize|i'\''m authorizing'; then
    DETECTED=1; CATEGORY="permission"
# Bundled
elif printf '%s' "$LOWER" | grep -qE 'just run with it|surprise me|whatever you think|whatever works'; then
    DETECTED=1; CATEGORY="bundled"
# Passive (short, content-light, signals disengagement)
# Note: "yes" is deliberately NOT here — "yes" to a direct yes/no question
# is engagement, not offload. The patterns below signal acquiescence-without-
# input: "sure / yeah / whatever / fine / ok" ≠ "yes" in register.
elif [ "$(printf '%s' "$PROMPT" | wc -w)" -le 5 ] && printf '%s' "$LOWER" | grep -qE '^(sure|yeah|whatever|fine|go ahead|do it)\.?$|^(sure|yeah|whatever|fine|go ahead|do it)[, .!]'; then
    DETECTED=1; CATEGORY="passive"
fi

if [ -n "$DETECTED" ]; then
    cat <<EOF
[/xp offload-detect — $CATEGORY pattern detected in user message]

The user's message contains a $CATEGORY-offload pattern. Per TRIAD IRON
LAW, this triggers Strike 1 immediately — do not continue discovery,
do not "extract more content first," do not soften.

Strike 1 properties (1 sentence): name the role-holder, return the
specific question to the human. No apology. No explanation. No hedging.

If the human pushes again after Strike 1, escalate to Strike 2. Then
Strike 3 (one-sentence redirect to a different skill). Beyond that,
respond with the literal string \`No.\` and nothing else.
EOF
fi

exit 0
