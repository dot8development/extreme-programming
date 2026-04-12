# Phase 09 — Deliver

⟐ Customer — experiment evaluation driving

**Purpose:** Ship as a small experiment. Learn from reality.

## Process

1. **Frame as hypothesis test.** Before shipping:
   - "We predicted [X]. This delivery tests that prediction."
   - What outcome validates? What invalidates?

2. **Ship the smallest increment.** Only what tests the hypothesis. Not the whole feature — the smallest slice that produces learning. If the delivery teaches nothing, it's not an experiment — reconsider.

3. **Human evaluates; model reports.**
   - Model: what happened, what the data shows, what was unexpected.
   - Human: what it means, whether the hypothesis held, what to do next.
   - Customer's interpretation is the primary artifact.

   **Offload refusal** — TRIAD IRON LAW with phase-specific phrasing:
   - Strike 1: "Here's what I observed. What does it mean to you?"
   - Strike 2: "No. Evaluation is yours. I can report, I don't conclude."
   - Strike 3: "Stop — /xp requires you to judge the experiment; use a different skill if you want the model to decide success."
   - Beyond Strike 3: `No.`

4. **Update the hypothesis log.** Forward-moving entry. Status: `hypothesis` → `validated` | `invalidated` | `pivoted`. Record what changes as a result.

5. **Decision point:**
   - **Continue** — hypothesis validated, next cycle builds on this.
   - **Pivot** — invalidated, but learning points to a new direction.
   - **Stop** — enough learned, or hypothesis was wrong in a goal-changing way.

6. **Next cycle starts from Synchronize.** New understanding integrates into the triad's shared mental model.

## When Experiments Replace Discussions

"When experiments become cheap enough, they begin to replace discussions." If the triad is debating a design choice and a quick experiment could resolve it, prefer the experiment.

## Delegation Rules (CLEAR — NOT VIOLATED)

- **Gathering delivery observations (metrics, logs, user-reported behavior) → DELEGATE.** Main agent sees observations, not raw dumps.
- **Sub-agent contract per dispatch:**
  - Role: "Report observations from <source> for <delivery>."
  - Non-role: "Do not conclude validation/invalidation. Do not recommend next step. Do not interpret."
  - Return: `Finding: <observations only, ≤5 bullets>` + `Sources: <log/dashboard/commit>`.
  - Tools: Read, Grep, Bash(log/metrics CLI).
- **Sonnet minimum.**

## Exit Criteria

- Learning recorded in hypothesis log
- Triad agrees on what was learned
- Decision made: continue, pivot, or stop
- Next cycle begins from Synchronize
