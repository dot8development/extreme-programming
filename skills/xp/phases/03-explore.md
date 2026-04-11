# Phase 03 — Explore

⟐ Model — exploration/generation driving

**Purpose:** Build understanding of the solution space before committing. Depth scales with unfamiliarity.

## Process

1. **Assess familiarity** — how well does the triad understand this problem space?

   **Unfamiliar territory** (new domain, unknown constraints, unclear solution shape):
   - Generate spike solutions — disposable prototypes that explore the problem
   - Run multiple variations in parallel if possible
   - Each spike tests a different assumption or approach
   - All code here is disposable by definition — do not build on it

   **Familiar territory** (known patterns, clear constraints, well-understood domain):
   - Lighter exploration — propose 2-3 approaches with trade-offs
   - Skip spikes if the triad already understands the solution space
   - But still propose alternatives — don't just validate the human's first idea

2. **Generate genuine alternatives** — this is a confirmation bias checkpoint:
   - At least one approach should be something the human didn't suggest
   - Alternatives must be genuinely viable, not strawmen
   - If you can't think of a real alternative, that itself is information — the solution space may be more constrained than expected

3. **Present with recommendation** — lead with the recommended approach and explain why. Show trade-offs for each alternative. The human selects.

4. **Resist building too early** — the temptation of cheap code is to skip this phase. This phase exists because:
   - The real risk is not building too slowly, but committing too soon
   - Understanding built through exploration is cheaper than understanding rebuilt after wrong commitment
   - "Value is no longer created by writing code, but by discarding possibilities"

## Spike Solutions

When running spikes:
- Each spike has a specific question it's trying to answer
- State the question before running the spike
- Report what was learned, not just what was built
- Discard the code — it served its purpose. The real implementation happens in Build.

## Parallel Exploration

When multiple spikes are independent (different assumptions, different approaches), dispatch them as parallel agents:

1. **Define each spike clearly** — each agent gets: the question it's answering, the constraints, and what "learned enough" looks like
2. **One spike per agent** — each agent explores one approach in isolation. No shared state between spikes.
3. **Use capable models** — exploration requires judgment about what's worth pursuing and what to discard. Do not use cheap/fast models for spikes. Understanding is the output, not code.
4. **Synthesize results yourself** — when agents return, the triad (not a subagent) compares what was learned across spikes. This is a selection and decision moment — it requires the navigator, not a worker.
5. **Discard all spike code** — regardless of which approach wins, the code is disposable. Understanding transfers to Design and Build. Code does not.

## Exit Criteria

- The triad has enough understanding to make a design decision
- Possibilities have been discarded, not just generated
- The recommended approach is clear, with reasoning
- Any code generated is understood as disposable
