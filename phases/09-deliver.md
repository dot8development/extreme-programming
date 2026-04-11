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

3. **Observe and learn** — after delivery:
   - What did we learn?
   - Was the hypothesis confirmed, invalidated, or inconclusive?
   - Did anything unexpected happen?
   - What do we now know that we didn't before?

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
