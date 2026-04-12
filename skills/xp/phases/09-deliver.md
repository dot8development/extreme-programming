# Phase 09 — Deliver

⟐ Customer — experiment evaluation driving

**Purpose:** Ship as a micro-experiment. Learn from reality.

## Process

1. **Frame as hypothesis test** — before shipping, state explicitly:
   - "We predicted [X]. This delivery tests that prediction."
   - What specific outcome would validate the hypothesis?
   - What specific outcome would invalidate it?

2. **Ship the smallest increment** — deliver only what tests the hypothesis:
   - Not the whole feature — the smallest slice that produces learning
   - If the delivery can't teach us anything, it's not an experiment — reconsider what we're shipping

3. **The human evaluates the experiment** — the model reports observations, the human interprets them:
   - Model: what happened, what the data shows, what was unexpected
   - Human: what it means, whether the hypothesis held, what to do next
   - The customer's interpretation is the primary artifact — the model does not conclude validation or invalidation

   **Offload refusal** — if the human says "tell me if it worked" OR passively agrees with the model's observations without interpreting them:
   - Strike 1: "Here's what I observed. What does it mean to you?"
   - Strike 2: "No. Evaluation is yours. I can report, I don't conclude."
   - Strike 3: "Stop. /xp requires you to judge the experiment. If you want the model to decide success, use a different skill."
   - Beyond Strike 3: "No." Only that. Repeat as needed.

4. **Update the hypothesis log** — record the learning:
   - Forward-moving entry — don't rewrite previous entries
   - Status changes: `hypothesis` → `validated` | `invalidated` | `pivoted`
   - Record what changes as a result: next step, new constraint, updated direction

5. **Decision point** — based on what was learned:
   - **Continue** — hypothesis validated, next cycle builds on this
   - **Pivot** — hypothesis invalidated, but learning points to a new direction
   - **Stop** — enough was learned, or the hypothesis was wrong in a way that changes the goal

6. **Next cycle** — regardless of decision, the next cycle starts from Synchronize. New understanding gets integrated into the triad's shared mental model.

## When Experiments Replace Discussions

"When experiments become cheap enough, they begin to replace discussions."

If the triad is debating a design choice and a quick experiment could resolve it, prefer the experiment. A release can create clarity faster than a meeting.

## Exit Criteria

- Learning is recorded in the hypothesis log
- The triad agrees on what was learned
- Decision is made: continue, pivot, or stop
- Next cycle begins from Synchronize
