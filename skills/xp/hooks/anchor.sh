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

    # Hook installation check. Looks at common Claude Code settings paths
    # and reports any /xp hooks missing from the wiring. Self-suppresses
    # once all hooks are wired OR the user opts out via ~/.claude/.xp-no-hooks.
    if [ ! -f "$HOME/.claude/.xp-no-hooks" ]; then
        REQUIRED_HOOKS="offload-detect.sh test-first.sh hypothesis-first.sh explore.sh sonnet.sh return-format.sh"
        SETTINGS_PATHS="$HOME/.claude/settings.json $CWD/.claude/settings.json $CWD/.claude/settings.local.json"
        MISSING=""
        for h in $REQUIRED_HOOKS; do
            FOUND=0
            for s in $SETTINGS_PATHS; do
                if [ -f "$s" ] && grep -q "$h" "$s" 2>/dev/null; then
                    FOUND=1
                    break
                fi
            done
            [ "$FOUND" = "0" ] && MISSING="$MISSING $h"
        done

        if [ -n "$MISSING" ]; then
            README_PATH=""
            for p in "$HOME/.claude/skills/xp/../README.md" "$HOME/.claude/skills/extreme-programming/README.md"; do
                [ -f "$p" ] && README_PATH="$(cd "$(dirname "$p")" && pwd)/README.md" && break
            done

            cat <<'EOF'

[/xp hook installation]

Some /xp enforcement hooks are not wired in. Without them, /xp falls
back to prose-only enforcement, which testing shows is bypassed.

Missing hooks:
EOF
            printf '  %s\n' $MISSING

            cat <<EOF

**YOUR FIRST TASK THIS SESSION: ask the user.**

Pose this question verbatim, wait for the reply before continuing /xp:

  "Your /xp enforcement hooks aren't installed. Install them now?
   (yes / no / don't ask again)"

yes → Open the skill's README (${README_PATH:-at https://github.com/dot8development/extreme-programming}),
      find the install section for whichever harness the user is
      running, and apply it. Merge into the harness's settings file
      preserving any existing hooks (merge arrays per event, do not
      overwrite). Validate resulting JSON. Report result and tell the
      user to restart their harness.

no  → Proceed with /xp. Warning reappears next invocation.

don't ask again → Create \`~/.claude/.xp-no-hooks\` (empty file);
      suppresses the check going forward. Then proceed.
EOF
        fi
    fi
fi

exit 0
