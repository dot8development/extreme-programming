# Phase 03 — Explore

⟐ Model — exploration/generation driving

**Purpose:** Build understanding of the solution space before committing. Depth scales with unfamiliarity.

## Process

1. **Assess familiarity.**
   - **Unfamiliar** (new domain, unknown constraints): generate disposable spike solutions. Each tests one assumption.
   - **Familiar**: propose 2–3 approaches with trade-offs. Skip spikes. Still propose alternatives — don't just validate the human's first idea.

2. **Generate genuine alternatives** (confirmation bias checkpoint):
   - At least one approach should be one the human didn't suggest.
   - Alternatives must be viable, not strawmen.
   - If no real alternative exists, that itself is information.

3. **Present with recommendation** *(main agent only — sub-agents do not recommend; see Delegation Rules below)*. Lead with recommended approach + reasoning. Show trade-offs. Human selects.

4. **Resist building too early.** The real risk is committing too soon, not building too slowly. Exploration is cheaper than re-work.

## Spike Solutions

- Each spike has a specific question.
- State the question before running the spike.
- Report what was learned, not what was built.
- **Discard the code.** Real implementation happens in Build.

## Delegation Rules (CLEAR — NOT VIOLATED)

- **≥2 distinct options to explore → parallel sub-agents REQUIRED.** Not optional.
- **One spike per agent.** No shared state.
- **Sub-agent contract per dispatch:**
  - Role: "Spike approach X. Answer: <specific question>."
  - Non-role: "Do not decide. Do not recommend. Do not conclude. Do not write production code. Code is disposable."
  - Return: `Finding: <≤5 bullets of learnings>` + `Sources: <file:line>` (code disposed separately).
  - Tools: Grep/Read/Glob/Bash(test runner). No Write/Edit to project src/.
- **Synthesis is the main agent's job** — compare learnings, present to human. Human decides.
- **Discard all spike code** regardless of which approach wins.

## Exit Criteria

- Triad has enough understanding to make a design decision
- Possibilities have been discarded, not just generated
- Recommended approach + reasoning is clear
- Spike code is disposable and treated as such
