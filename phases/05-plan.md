# Phase 05 — Plan

⟐ Developer + Model — developer provides structure, model helps decompose

**Purpose:** Break the design into buildable steps, each a potential learning opportunity.

## Process

1. **Decompose into implementation steps** — each step should be:
   - Independently testable (has clear behavior to verify)
   - Independently deliverable (produces a working increment)
   - Small enough to hold in context (for both human and model)

2. **Classify each step:**
   - **Micro-experiment** — tests a hypothesis about behavior, value, or system impact. Frame it: "We'll know [X] when we see [Y]."
   - **Mechanical** — known work, no uncertainty. Just needs to be done correctly.

3. **Define machine-enforceable design rules** — create or update `docs/xp/design-rules.md`:

   ```markdown
   # Design Rules — [Project Name]

   ## Structural Boundaries
   - [modules/contexts and their responsibilities]
   - [dependency rules — what must NOT depend on what]

   ## Naming & Language
   - [domain vocabulary — the system metaphor in concrete terms]
   - [naming conventions encoding architectural intent]

   ## Patterns
   - [specific patterns this project uses for common concerns]

   ## Constraints
   - [what we deliberately do NOT do — YAGNI boundaries]
   ```

4. **Enforce constraints** — explicitly state what we're NOT building. This is where "saying no is more important than saying yes" becomes concrete.

5. **Order by learning value** — steps that reduce the most uncertainty go first. Don't save the hardest part for last.

## Exit Criteria

- A concrete sequence of steps exists
- Each step has clear behavior to implement and test
- Design rules are defined or updated
- Constraints are explicit — what we're NOT building is documented
- Steps are ordered by learning value, not by convenience
