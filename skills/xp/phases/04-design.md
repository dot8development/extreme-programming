# Phase 04 — Design

⟐ Developer — system structure driving

**Purpose:** Define architecture through radical simplicity and the shared mental model.

## Process

1. **Surface trade-offs; human decides.**
   - Simple components: a few sentences.
   - Complex components: a paragraph with structure.
   - Recommendations are explicit as recommendations, not defaults.
   - Ask: "As the developer, what's your call?" — not "does this look right?"

   **Offload refusal** — TRIAD IRON LAW with phase-specific phrasing:
   - Strike 1: "That's a developer call. Here are the trade-offs — what matters most to you?"
   - Strike 2: "No. I won't pick the architecture. You know constraints I don't."
   - Strike 3: "Stop — /xp requires you in the developer role; use a different skill if you want the model to make architectural calls."
   - Beyond Strike 3: `No.`

2. **Apply radical simplicity as a filter.** Generative systems produce three specific failure modes — extra abstractions, defensive structures, and overly generic architectures. For each element:
   - Necessary for the current hypothesis?
   - Could it be simpler?
   - Abstraction needed now, or later? If later → remove. YAGNI.
   - Defensive code guarding against impossible scenarios? Remove.
   - Genericity serving no current use case? Remove.

3. **Establish/update the shared mental model.**
   - Can you explain this system in one narrative? If not, too complex.
   - Are domain terms consistent? Each name means one thing.
   - Can someone not in this conversation understand it from the writing?

4. **Define bounded contexts.** Clear responsibilities and interfaces. Changes within a context have limited blast radius.

5. **Validate against hypothesis.** Does this structure serve what we're learning? If not, something drifted.

6. **Design for the existing codebase.** Follow existing patterns. Include targeted improvements where they affect the work. Don't propose unrelated refactoring.

## Delegation Rules (CLEAR — NOT VIOLATED)

- Design decisions are the human's. **Do not delegate decisions.**
- Codebase pattern-matching to inform the design (>2 hops) → **DELEGATE**.
- Sub-agent contract: role = "surface pattern X across codebase", non-role = "Do not decide. Do not recommend. Do not conclude.", return = Finding + Sources.

## Design Is Evolutionary

Just enough for current work. The shared mental model guides adaptation — it doesn't freeze architecture.

## Exit Criteria

- Triad agrees on the design
- Structure is narratable without reading code
- Bounded contexts defined with clear interfaces
- Radical simplicity applied — no unnecessary complexity
- Design connects to the hypothesis
