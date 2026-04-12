# Phase 01 — Synchronize

⟐ Customer + Developer + Model — full triad sync

**Purpose:** Establish the triad's shared mental model before anything else.

## Process

1. **Read primary artifacts in order:**
   - `docs/xp/hypothesis-log.md` — what's the active hypothesis?
   - `docs/xp/design-rules.md` — what constraints are active?
   - Recent `git log` — what was actually committed?
   - Test suite — do tests pass?
   - Source code — does it match the hypothesis log?

2. **Reconstruct, don't remember.** If it's not in an artifact, it's not known. Conversation memory is not authoritative.

3. **Branch:**
   - **No artifacts** → fresh start, transition to Phase 02.
   - **Artifacts exist** → summarize active hypothesis, last phase, key decisions. Surface contradictions between artifacts. Confirm with human: "Here's where we are. Does this match your understanding?" Then transition to the appropriate phase.

4. **Surface contradictions; don't silently resolve.** "Log says X, code shows Y. Which is current?" Contradictions are drift signals.

## Mid-Session Re-Anchoring

Re-anchor (lightweight version) when: phase transitions, hypothesis updates/invalidates, output contradicts an artifact, resumption after any break. Re-read hypothesis log; don't re-read the full codebase unless contradictions appear.

## Delegation Rules (CLEAR — NOT VIOLATED)

- Reading artifacts is fast and small. **Main agent reads them directly.**
- If resolving contradictions requires >3 codebase hops → **DELEGATE** per DELEGATION IRON LAW.

## Exit Criteria

- Triad agrees on where we are and what we know
- No unresolved contradictions
- Clear next-phase transition identified
