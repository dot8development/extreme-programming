# Phase 05 — Plan

⟐ Developer + Model — developer provides structure, model helps decompose

**Purpose:** Break the design into buildable, learning-producing steps.

## Process

1. **Decompose into implementation steps.** Each step:
   - Independently testable (clear behavior to verify)
   - Independently deliverable (produces a working increment)
   - Small enough to hold in context (for human and model)

2. **Classify each step:**
   - **Micro-experiment** — tests a hypothesis: "We'll know [X] when we see [Y]."
   - **Mechanical** — known work, no uncertainty.
   - **Parallel-eligible** — independent (no shared state, no sequential dependency). Flag these for parallel dispatch in Build. Steps that depend on each other are sequential — never mark them parallel.

3. **Human codifies design rules; model surfaces patterns.** Create/update `docs/xp/design-rules.md`:

   **Offload refusal** — TRIAD IRON LAW with phase-specific phrasing:
   - Strike 1: "I can surface the patterns I see. The rules are yours to declare."
   - Strike 2: "No. Design rules are a developer artifact. Tell me what should be enforced."
   - Strike 3: "Stop — /xp requires you to own the rules; use a different skill if you want the model to set them."
   - Beyond Strike 3: `No.`

   ```markdown
   # Design Rules — [Project Name]

   ## Structural Boundaries
   - [modules/contexts and their responsibilities]
   - [dependency rules — what must NOT depend on what]

   ## Naming & Language
   - [domain vocabulary — the system metaphor in concrete terms]
   - [naming conventions encoding architectural intent]

   ## Patterns
   - [specific patterns this project uses]

   ## Constraints
   - [what we deliberately do NOT do — YAGNI boundaries]
   ```

4. **Enforce constraints.** Explicitly state what we're NOT building. "Saying no is more important than saying yes" becomes concrete here.

5. **Order by learning value.** Steps that reduce the most uncertainty go first. Don't save the hardest for last.

## Delegation Rules (CLEAR — NOT VIOLATED)

- Surfacing existing patterns for rule authorship (>2 hops) → **DELEGATE**.
- Sub-agent contract: role = "find instances of pattern X", non-role = "Do not decide. Do not recommend. Do not conclude. Do not formulate rules.", return = Finding + Sources.

## Exit Criteria

- Concrete step sequence exists
- Each step has clear behavior to implement and test
- Design rules defined or updated
- Constraints explicit — what we're NOT building is documented
- Steps ordered by learning value, not convenience
- Parallel-eligible steps flagged
