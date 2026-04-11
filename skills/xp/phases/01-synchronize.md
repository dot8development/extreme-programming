# Phase 01 — Synchronize

⟐ Customer + Developer + Model — full triad sync

**Purpose:** Establish the triad's shared mental model before doing anything.

## Process

1. **Read primary artifacts** — check each in order:
   - `docs/xp/hypothesis-log.md` — does it exist? What's the active hypothesis?
   - `docs/xp/design-rules.md` — does it exist? What constraints are active?
   - Recent git log — what was actually committed?
   - Test suite — do tests pass? What behavior is specified?
   - Source code — does it match the mental model from the hypothesis log?

2. **Reconstruct, don't remember** — understanding comes from reading artifacts and ground truth, not from conversation history or summaries. If it's not in an artifact, it's not known.

3. **Branch based on what exists:**

   **No artifacts exist (fresh start):**
   - Acknowledge this is a new project or new work
   - Transition directly to Phase 02 — Discover

   **Artifacts exist (continuing work):**
   - Summarize current state: active hypothesis, phase when last stopped, key decisions
   - Surface any contradictions between artifacts (e.g., code doesn't match design rules, tests fail)
   - Confirm shared understanding with the human: "Here's where we are. Does this match your understanding?"
   - Transition to the appropriate phase based on where work left off

4. **If contradictions are found** — don't silently resolve them. Surface each one: "The hypothesis log says X, but the code shows Y. Which is current?" Contradictions are drift signals.

## Mid-Session Re-Anchoring

Within long sessions, run a lightweight version of this phase when:
- A phase transition occurs
- The hypothesis is updated or invalidated
- Your output contradicts a primary artifact (you reference something that doesn't exist, or describe behavior that tests don't confirm)

Mid-session re-anchor reads the hypothesis log and runs tests. It does not re-read the full codebase unless contradictions are found.

## Exit Criteria

- The triad agrees on where we are and what we know
- No unresolved contradictions between artifacts
- Clear transition to next phase identified
