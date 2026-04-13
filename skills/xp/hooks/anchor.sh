#!/usr/bin/env bash
# xp/anchor.sh — UserPromptSubmit hook (INJECTION, not GATE)
#
# Hook type: INJECTION. Writes to stdout to prepend context. This is the
# deliberate exception to the "silent success" principle that governs gate
# hooks (test-first.sh, hypothesis-first.sh). Injection hooks add context;
# gate hooks block violations. Different jobs, different output rules.
#
# When the user invokes /xp, prepend an anchoring reminder so the model is
# forced to re-read primary artifacts BEFORE responding. Implements Iron
# Law #3: "DO NOT skip Phase 01 (Synchronize)."
#
# Fires only when:
#   - Prompt starts with "/xp" (case insensitive, leading whitespace allowed)
#
# Output: text on stdout is prepended to the user's message in the agent's
#         context window. Exit 0 always.

set -euo pipefail

INPUT=$(cat)

# Extract the prompt. Use python for robust JSON parsing if available,
# else fall back to a best-effort grep.
PROMPT=""
if command -v python3 >/dev/null 2>&1; then
    PROMPT=$(printf '%s' "$INPUT" | python3 -c 'import sys,json; d=json.load(sys.stdin); print(d.get("prompt",""))' 2>/dev/null || printf '')
elif command -v python >/dev/null 2>&1; then
    PROMPT=$(printf '%s' "$INPUT" | python -c 'import sys,json; d=json.load(sys.stdin); print(d.get("prompt",""))' 2>/dev/null || printf '')
else
    PROMPT=$(printf '%s' "$INPUT" | sed -n 's/.*"prompt"[[:space:]]*:[[:space:]]*"\(.*\)".*/\1/p' | head -1)
fi

# Normalize: strip leading whitespace, lowercase the command token
TRIMMED=$(printf '%s' "$PROMPT" | sed 's/^[[:space:]]*//')
CMD=$(printf '%s' "$TRIMMED" | awk '{print tolower($1)}')

if [ "$CMD" = "/xp" ]; then
    CWD=$(pwd)
    HYP="$CWD/docs/xp/hypothesis-log.md"
    RULES="$CWD/docs/xp/design-rules.md"

    cat <<'EOF'
[/xp anchor — Phase 01 Synchronize REQUIRED before responding]

Iron Law #3: You MUST NOT skip Phase 01. Before responding to this /xp
invocation you MUST:

  1. Read docs/xp/hypothesis-log.md (if it exists)
  2. Read docs/xp/design-rules.md (if it exists)
  3. Summarize where /xp left off and confirm with the human

If neither file exists → this is a fresh start. Say so and transition to
Phase 02 (Discover). You still MUST NOT skip the summary step.

You MUST NOT decide from ambient context. You MUST NOT fill information
gaps from the working directory. If "my app" is ambiguous, ASK.
EOF

    if [ -f "$HYP" ]; then
        printf '\nStatus: docs/xp/hypothesis-log.md EXISTS — read it first.\n'
    else
        printf '\nStatus: docs/xp/hypothesis-log.md does NOT exist — fresh start.\n'
    fi

    if [ -f "$RULES" ]; then
        printf 'Status: docs/xp/design-rules.md EXISTS — read it first.\n'
    else
        printf 'Status: docs/xp/design-rules.md does NOT exist — will be created in Phase 05.\n'
    fi
fi

exit 0
