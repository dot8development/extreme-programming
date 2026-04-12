# Phase 07 — Verify

⟐ Developer + Model — model runs verification, developer judges coherence

**Purpose:** Continuous system verification. CI as the immune system.

## Process

1. **Run the full test suite.** Not just new tests. The entire suite. A failing test is a drift signal — don't skip, don't mark as known-failure.

2. **Check for probabilistic drift.** Unintended behavioral changes? Patterns inconsistent with the system? New unplanned dependencies?

3. **Verify structural coherence.** Does the codebase match the shared mental model? Can you narrate the structure? Bounded contexts still bounded?

4. **Verify conformance.** Read `docs/xp/design-rules.md`. Check each rule against current code. Violations are surfaced, not silently fixed.

5. **Cross-agent coherence** (after parallel Build) — did independent agents introduce conflicting patterns or naming? Do components integrate cleanly? Parallel work multiplies entropy risk.

6. **Limit blast radius.** What files changed? Within expected bounded context? Any leak into unrelated areas?

7. **The understanding gate.** "Tests pass" is necessary, not sufficient. The system must be understood and ready for integration. If any change can't be explained, it's not verified.

## Delegation Rules (CLEAR — NOT VIOLATED)

- **Test suite execution → DELEGATE.** Main agent sees findings only. Silent success, loud failure.
- **Design rule checking across codebase → DELEGATE.** Parallel if rules are independent.
- **Cross-agent coherence check → DELEGATE** to a dedicated sub-agent that reads all parallel-build outputs together.
- **Sub-agent contract per dispatch:**
  - Role: "Run <check X>. Report failures and their locations."
  - Non-role: "Do not fix. Do not decide severity. Do not conclude the system is ready."
  - Return: `Finding: <failures only, ≤5 bullets>` + `Sources: <file:line or test name>`. **Empty Finding = silent pass.**
  - Tools: Bash(test runner, linter), Read, Grep.
- **Sonnet minimum.**

## Exit Criteria

- Full test suite passes
- No probabilistic drift detected
- Structural coherence confirmed
- Design rules satisfied — no violations
- Blast radius contained
- Cross-agent coherence confirmed (if parallel work dispatched)
- The triad can explain every change
