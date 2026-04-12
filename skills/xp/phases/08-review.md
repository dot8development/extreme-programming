# Phase 08 — Review

⟐ Customer + Developer — can both perspectives make sense of this?

**Purpose:** Radical code transparency. The triad must collectively understand what exists.

## Process

Five distinct checks. Passing one does not pass another.

1. **Transparency check** — can someone not present understand this code?
   - Is intent clear from structure and naming alone?
   - Would you need the author to explain? If yes, not transparent.
   - Black boxes = failure.

2. **Consistency check** — code conforms to `docs/xp/design-rules.md`?
   - Naming matches domain vocabulary.
   - Structural boundaries respected.
   - Patterns consistently applied.
   - Separate from transparency — code can be transparent but inconsistent.

3. **Simplicity check** — simplest possible implementation?
   - Any abstraction removable without losing functionality?
   - Defensive structures guarding against impossible scenarios?
   - Genericity serving no current use case?
   - Default answer to "keep this?" is no.

4. **Mental model check** — code matches the shared mental model?
   - Does the code tell the same story as the design?
   - Any components outside the narrative?

5. **Invert the default** — actively seek what might be wrong:
   - What could break here?
   - What untested assumption?
   - Weakest point?

## Delegation Rules (CLEAR — NOT VIOLATED)

- **Reviewing >1 file or >200 lines → DELEGATE.** Findings-only return.
- Checks 1–4 can run in parallel. Check 5 runs after — it needs 1–4's findings.
- **Sub-agent contract per dispatch:**
  - Role: "Run <check N> on <file set>."
  - Non-role: "Do not fix. Do not rank. Do not conclude overall review status."
  - Return: `Finding: <violations only>` + `Sources: <file:line>`. Empty = silent pass.
  - Tools: Read, Grep.
- **Sonnet minimum.**

## Exit Criteria

- All five checks pass
- No black boxes
- No unexamined assumptions
- Radical code transparency confirmed
