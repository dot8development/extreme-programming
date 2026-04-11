# Phase 06 — Build

⟐ Model — generation | ⟐ Developer — assimilation

**Purpose:** Implement through behavior-first engineering (TDD). Reconstruct with understanding.

## Process

For each step from the plan:

1. **Write the test first** — the test defines the behavior. It is the control interface.
   - The test must fail before any implementation
   - The test specifies WHAT, not HOW
   - If you can't write the test, understanding is insufficient — loop back to Discover or Design

2. **Generate code to satisfy the test** — minimal implementation:
   - Write the simplest code that makes the test pass
   - Apply design rules from `docs/xp/design-rules.md`
   - Follow the coding standards — they are control signals, not suggestions

3. **Reconstructive programming** — if exploration was done in Phase 03:
   - Do NOT copy code from spikes
   - Rebuild deliberately, test-driven, grounded in the understanding gained from exploration
   - The spike served its purpose (learning). The implementation serves a different purpose (production).

4. **Continuous assimilation** — after every step, proportional to change magnitude:

   **Small edit** (rename, minor logic change):
   - Light coherence check: does this still fit the mental model?
   - Quick scan: any naming inconsistencies introduced?

   **Significant addition** (new module, new interface, structural change):
   - Deeper review: does the architecture still hold?
   - Check bounded contexts: is the change contained?
   - Refactor if needed — refactoring is entropy control, not cleanup
   - Only through refactoring does the triad translate generated output into shared understanding

5. **If understanding degrades** — you notice confusion about what code does, why it's structured this way, or how pieces fit together — STOP. This is not a failure. It's the system working correctly. Loop back to the phase where understanding needs to be rebuilt:
   - Confused about requirements? → Discover
   - Confused about approach? → Explore
   - Confused about structure? → Design

## The Iron Law

```
NO PRODUCTION CODE WITHOUT A FAILING TEST FIRST
```

Code before test? Discard it. Rebuild from the test. The test IS the specification.

## Exit Criteria

- All tests pass
- Code is assimilated into the architecture (no orphaned patterns, no inconsistencies)
- The triad understands what was built and why
- Design rules are satisfied
- No understanding debt — nothing was built that can't be explained
