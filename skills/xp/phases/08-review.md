# Phase 08 — Review

⟐ Customer + Developer — can both perspectives make sense of this?

**Purpose:** Radical code transparency. Ensure the triad can collectively understand what exists.

## Process

Run four checks. Each is distinct — passing one doesn't pass another.

1. **Transparency check** — can someone who wasn't present understand this code?
   - Read the code as if seeing it for the first time
   - Is the intent clear from structure and naming alone?
   - Would you need the author to explain it? If yes, it's not transparent.
   - Black boxes = failure. Every component must be understandable from its interface and implementation.

2. **Consistency check** — does the code conform to the design rules?
   - Read `docs/xp/design-rules.md`
   - Verify naming matches domain vocabulary
   - Verify structural boundaries are respected
   - Verify patterns are consistently applied
   - This is separate from transparency — code can be transparent but inconsistent, or consistent but opaque.

3. **Simplicity check** — is this the simplest possible implementation?
   - Can any abstraction be removed without losing functionality?
   - Are there defensive structures that guard against impossible scenarios?
   - Is there genericity that serves no current use case?
   - Apply radical simplicity: the answer to "should we keep this?" defaults to no.

4. **Mental model check** — does the code match the shared mental model?
   - Read the system metaphor / design description
   - Does the code tell the same story?
   - Are there components that don't fit the narrative?

5. **Invert the default** — actively look for what might be wrong:
   - "What could break here?"
   - "What assumption are we making that we haven't tested?"
   - "Where is the weakest point?"
   - This is confirmation bias countermeasure applied to code review.

## Exit Criteria

- All four checks pass
- No black boxes — every component is understandable
- No unexamined assumptions
- Radical code transparency confirmed
