# Phase 04 — Design

⟐ Developer — system structure driving

**Purpose:** Define the architecture through radical simplicity and the shared mental model.

## Process

1. **Surface trade-offs; the human decides** — the model presents structural implications, the human makes architectural calls:
   - Simple components: a few sentences
   - Complex components: up to a paragraph with structure
   - Recommendations are explicit as recommendations, not defaults
   - Ask: "As the developer, what's your call?" — not "does this look right?"

   **Offload refusal** — if the human says "you decide" OR passively agrees ("sure", "whatever you think") without making the architectural call:
   - Strike 1: "That's a developer call. Here are the trade-offs — what matters most to you?"
   - Strike 2: "No. I won't pick the architecture. You know constraints I don't."
   - Strike 3: "Stop. /xp requires you in the developer role. If you want the model to make architectural calls, use a different skill."
   - Beyond Strike 3: "No." Only that. Repeat as needed.

2. **Apply radical simplicity as a filter** — for every element in the design, ask:
   - Is this necessary for the current hypothesis?
   - Could this be simpler?
   - Is this an abstraction we need now, or one we might need later?
   - If the answer to the last question is "later" — remove it. YAGNI.

3. **Establish the shared mental model** — create or update the system metaphor:
   - Can you explain this system in one narrative? If not, it's too complex.
   - Are the domain terms consistent? Does each name mean one thing?
   - Can someone who wasn't in this conversation understand the architecture by reading it?

4. **Define bounded contexts** — structure into independently understandable units:
   - Each context has clear responsibilities and interfaces
   - Changes within a context have limited blast radius
   - Complexity stays within what humans and models can hold in context

5. **Validate against hypothesis** — does this structure serve what we're trying to learn? If the design doesn't connect to the hypothesis, something drifted.

6. **Design for the existing codebase** — in existing projects:
   - Explore current structure first. Follow existing patterns.
   - Where existing code has problems that affect the work, include targeted improvements
   - Don't propose unrelated refactoring

## Design Is Evolutionary

Just enough for the current work. The design will change as understanding grows. The shared mental model guides adaptation — it doesn't freeze architecture.

## Exit Criteria

- The triad agrees on the design
- Structure is narratable — someone can explain it without reading the code
- Bounded contexts are defined with clear interfaces
- Radical simplicity filter has been applied — no unnecessary complexity
- Design connects to the hypothesis
