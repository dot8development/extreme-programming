# Phase 06 — Build

⟐ Model — generation | ⟐ Developer — assimilation

**Purpose:** Implement through behavior-first engineering (TDD). Reconstruct with understanding.

## The Iron Law

```
NO PRODUCTION CODE WITHOUT A FAILING TEST FIRST
```

Code before test? Discard it. Rebuild from the test. The test IS the specification.

Hook `test-first.sh` enforces this on Write/Edit to src/. Exit 2 blocks. If blocked, **fix the underlying violation** — don't circumvent.

## Process

For each step from the plan:

1. **Write the test first.** The test defines behavior. It must fail before any implementation. Specifies WHAT, not HOW. If you can't write the test, understanding is insufficient — loop back to Discover or Design.

2. **Generate code to satisfy the test.** Minimal implementation. Apply design rules from `docs/xp/design-rules.md`. Coding standards are control signals, not suggestions.

3. **Reconstructive programming.** If exploration ran in Phase 03:
   - Do NOT copy code from spikes.
   - Rebuild deliberately, test-driven, grounded in understanding gained.
   - Spikes served learning; implementation serves production.

4. **Continuous assimilation** after every step, proportional to change:
   - **Small edit**: light coherence check; scan for naming inconsistencies.
   - **Significant addition**: deeper review; confirm bounded contexts hold; refactor if needed (refactoring = entropy control, not cleanup). Assimilation is how generated output becomes shared understanding.

5. **If understanding degrades, STOP.** Loop back:
   - Confused about requirements? → Discover
   - Confused about approach? → Explore
   - Confused about structure? → Design

## Delegation Rules (CLEAR — NOT VIOLATED)

- **Parallel-eligible steps from Phase 05 → parallel sub-agents REQUIRED.** Not optional.
- **Independence is the gate** — if step B depends on step A's output, sequential. Only truly independent steps parallel.
- **Running tests/builds → DELEGATE.** Main agent sees Findings, not raw output. Silent success, loud failure.
- **Sub-agent contract per dispatch:**
  - Role: "Implement step X per test Y. Apply design rules."
  - Non-role: "Do not modify unrelated files. Do not skip failing tests. Do not generate code without the test first. Do not decide scope."
  - Return: `Finding: <≤5 bullets — what was built; test failures only; rule violations only>` + `Sources: <file:line>`. Empty test/rule lines = silent pass.
  - Tools: Read, Write, Edit, Bash(test runner), Grep, Glob. Scoped to step files only.
- **Sonnet minimum.** Never Haiku. TDD discipline requires judgment.
- **Never parallelize assimilation.** Assimilation is the triad's coherence judgment — sequential, after parallel work converges.
- **Assimilate after convergence** — parallel work multiplies entropy risk. Deeper check across combined output.

## Exit Criteria

- All tests pass
- Code assimilated into architecture — no orphaned patterns, no inconsistencies
- Triad understands what was built and why
- Design rules satisfied
- No understanding debt — nothing built that can't be explained
