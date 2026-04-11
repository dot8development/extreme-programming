# Phase 07 — Verify

⟐ Developer + Model — model runs verification, developer judges coherence

**Purpose:** Continuous system verification. CI as the immune system.

## Process

1. **Run the full test suite** — not just new tests. The entire suite.
   - If any test fails, investigate. Don't skip, don't mark as known-failure.
   - A failing test is a drift signal — something changed that shouldn't have, or something didn't change that should have.

2. **Check for probabilistic drift** — do system-level properties still hold?
   - Are there behavioral changes that weren't intended?
   - Did code generation introduce patterns inconsistent with the rest of the system?
   - Are there new dependencies that weren't in the design?

3. **Verify structural coherence** — does the codebase match the shared mental model?
   - Can you narrate the system's structure? If a component doesn't fit the narrative, it's drifted.
   - Are bounded contexts still bounded? Did anything leak across boundaries?

4. **Verify conformance** — does the code satisfy the design rules?
   - Read `docs/xp/design-rules.md`
   - Check each rule against the current code
   - Any violation is surfaced, not silently fixed

5. **Cross-agent coherence** (after parallel work) — when Build dispatched parallel agents:
   - Did independent agents introduce conflicting patterns or naming?
   - Do the separately-built components integrate cleanly?
   - Is the combined output coherent as a whole, not just individually correct?
   - Parallel work multiplies entropy risk — verify proportionally deeper.

6. **Limit blast radius** — confirm changes are contained:
   - What files were changed?
   - Are the changes within the expected bounded context?
   - Did any change leak into unrelated areas?

7. **The understanding gate** — this is the critical distinction from basic CI:
   - "Tests pass" is necessary but not sufficient
   - The system must be "understood and ready for integration"
   - Can the triad explain every change? If any change can't be explained, it's not verified.

## Exit Criteria

- Full test suite passes
- No probabilistic drift detected
- Structural coherence confirmed — codebase matches mental model
- Design rules satisfied — no violations
- Blast radius contained — changes are within expected boundaries
- The triad can explain every change
