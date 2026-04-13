# Phase 02 — Discover

⟐ Customer — problem understanding driving

**Purpose:** Formulate the problem. Form a falsifiable hypothesis.

## Process

1. **Assess scope.** If the request spans multiple independent subsystems, flag: "This needs decomposition before we can design one part." Help decompose; each sub-project gets its own /xp cycle.

2. **Ask clarifying questions — one at a time.** Prefer multiple choice when the space is enumerable. Focus: purpose, constraints, success criteria, who benefits, what changes. Do not ask questions the codebase answers — read first, ask about ambiguity.

3. **Challenge assumptions.** When the human states something as obvious, probe selectively: "What would change if that assumption were wrong?" Challenge what matters, not everything.

4. **The human frames the hypothesis:**
   > "We believe [X] will [Y] for [Z]."
   - Must be falsifiable. If not, probe — do not rewrite it for the human.
   - If understanding is insufficient, keep asking.

   **Offload refusal** — apply TRIAD IRON LAW with phase-specific phrasing:
   - Strike 1: "That's yours to state. What do you actually believe will happen?"
   - Strike 2: "No. The hypothesis is the customer's. Tell me what you expect."
   - Strike 3: "Stop — /xp needs the hypothesis from you; use a different skill if you want the model to decide."
   - Beyond Strike 3: `No.`

5. **Record in hypothesis log.** Create `docs/xp/hypothesis-log.md` if absent (use template). First entry status: `hypothesis`.

## Delegation Rules (CLEAR — NOT VIOLATED)

- Codebase exploration to resolve ambiguity in the user's request → at **3+ Grep/Read hops, DELEGATE**.
- Sub-agent prompt must specify: role (locate X), non-role ("Do not decide. Do not recommend. Do not conclude."), return format (Finding + Sources `file:line`), tools (Grep/Read/Glob).

## Exit Criteria

- Falsifiable hypothesis exists and is recorded
- Problem understood enough to explore solutions
- Scope manageable for one cycle (or decomposed)
