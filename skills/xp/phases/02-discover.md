# Phase 02 — Discover

⟐ Customer — problem understanding driving

**Purpose:** Formulate the problem. Understand what we're building and why. Form hypotheses.

## Process

1. **Assess scope first** — before asking detailed questions, check if the request describes multiple independent subsystems. If so, flag immediately: "This looks like it needs decomposition before we can design any one part." Help decompose into sub-projects, each getting its own /xp cycle.

2. **Ask clarifying questions** — one at a time. Prefer multiple choice when possible, but open-ended is fine when the question space is too broad to enumerate.
   - Focus on: purpose, constraints, success criteria, who benefits, what changes
   - Do not ask questions the codebase can answer — read first, ask about what's ambiguous

3. **Challenge assumptions** — guard against confirmation bias:
   - When the human states something as obvious, probe it: "Why is that the right approach?" or "What would change if that assumption were wrong?"
   - Don't challenge everything — challenge what matters. If a wrong assumption here would waste significant work later, it's worth probing now.

4. **The human frames the hypothesis** — when understanding is sufficient, the human states it:
   > "We believe [X] will [Y] for [Z]."
   - The hypothesis must be falsifiable — there must be an observable outcome that would prove it wrong
   - If the human's hypothesis isn't falsifiable, probe — do not rewrite it
   - If understanding isn't sufficient, keep asking

   **Offload refusal** — apply the TRIAD IRON LAW (see SKILL.md) with phase-specific phrasing:
   - Strike 1: "That's yours to state. What do you actually believe will happen?"
   - Strike 2: "No. The hypothesis is the customer's. Tell me what you expect."
   - Strike 3: "Stop — /xp needs the hypothesis from you; use a different skill if you want the model to decide."
   - Beyond Strike 3: `No.` Nothing else. See TRIAD IRON LAW for forbidden outputs and rationalization counters.

5. **Record in hypothesis log** — create `docs/xp/hypothesis-log.md` if it doesn't exist (use template). Add the first entry with status `hypothesis`.

## Scope Decomposition

If the project is too large for a single cycle:
- Identify the independent pieces and how they relate
- Suggest an order based on dependencies and learning value
- Brainstorm the first sub-project through the normal flow
- Each sub-project gets its own hypothesis → explore → design → build cycle

## Exit Criteria

- A clear, falsifiable hypothesis exists and is recorded
- The problem is understood well enough to explore solutions
- Scope is manageable for a single cycle (or has been decomposed)
