# /xp — Extreme Programming in the Age of AI

A skill that implements the full software development lifecycle as a single, unified workflow grounded in Frank Westphal's [Extreme Programming in the Age of AI](https://frankwestphal.de/ExtremeProgrammingintheAgeofAI.html). Model-agnostic — works with any coding agent or LLM.

This is not a collection of tools. It is a cohesive system of reinforcing practices designed to keep the cost of understanding low in a world where code generation is cheap and human judgment is the scarcest resource.

---

## Core Mission

**Keep the cost of understanding low.**

## Meta-framing

We are not programming systems. We are programming the conditions under which systems emerge. Generated code is fundamentally different from hand-written code — it is not purely intentional, but the result of a stochastic process. This changes everything: how we evaluate it, how we trust it, how we integrate it, and why every principle below exists.

---

## Principles

### 1. Practices reinforce each other through tight feedback loops

No principle here stands alone. TDD makes refactoring safe. Refactoring makes assimilation possible. Assimilation keeps the mental model coherent. The mental model makes design decisions sound. The mechanism that connects them is feedback loops at every timescale — seconds (tests), minutes (assimilation), hours (integration), days (experiments). Maximizing the rate of learning means keeping these loops tight.

### 2. Tests are the primary artifact, code is derivative

Tests define behavior. Code is generated to satisfy them. If code is lost but tests remain, the system can be rebuilt. Tests are the programming language used to control coding agents and the contract between humans and machines.

### 3. The shared mental model is the generative architecture

The system needs a narratable structure — metaphors, domain models, naming conventions — that makes complexity collectively manageable. Without it, locally meaningful code becomes globally incoherent. Design is evolutionary, not predictive: the mental model guides continuous adaptation rather than upfront planning. It is what makes generation coherent, not the other way around.

### 4. Understanding decays, entropy grows

Every generated change risks structural drift — the gradual divergence of a system from its original structure and semantics under seemingly identical conditions. The skill actively counteracts this through continuous assimilation, never allowing code to exist that the triad doesn't understand.

### 5. Exploration is the default mode of working, reconstruction creates understanding

Generated code is first an exploration tool — disposable by nature. The actual implementation is then deliberately rebuilt, test-driven and grounded in understanding. The depth of exploration scales with unfamiliarity, but the cycle of explore, discard, rebuild is how work gets done. Guard against building too early — the temptation of cheap code is to skip exploration and jump to implementation before understanding is sufficient. The real risk is not building too slowly, but committing too soon.

### 6. Value comes from discarding possibilities, not producing code

When options explode, selection becomes the bottleneck. Enforcing constraints is a key skill. Saying no is more important than saying yes.

### 7. The thinking process is persistent

Hypotheses, decisions, and learnings are recorded as a forward-moving log — an external record of the decision tree that is reviewable, versionable, and reproducible. This is the triad's shared memory across sessions and a new team artifact: not just code and tests, but the path to the decision.

### 8. Radical code transparency over code ownership

Authorship is meaningless. Code changes at any time by humans or agents. What matters is that structure and intent remain understandable to everyone. The question is never "who wrote this" but "can the triad understand this." The goal is to maximize the reduction of black-box risk.

### 9. Design is machine-enforceable

Coding standards are not social conventions — they are control signals for generative code. They become the system prompt of the repository, preventing continuously generated code from losing coherence.

### 10. Radical simplicity is a filter against generative complexity

Generative systems tend toward overcomplexity — extra abstractions, defensive structures, overly generic architectures. The team's task is less about inventing solutions and more about consistently removing complexity. This is one of the most critical skills in the age of generated code.

### 11. Guard against confirmation bias

AI amplifies confirmation bias. Critical reflection can decrease. False assumptions scale faster than ever. The triad exists partly as a counterweight — the tension between customer, developer, and model perspectives increases collective intelligence. The skill must actively challenge assumptions, not just validate them.

### 12. Sustainable cognitive load is a system invariant

The skill self-regulates the density of decisions it asks of the human. AI shifts the constraint into the human mind — as iteration speed increases, so do decision pressure, context switching, and mental load. Speed is never prioritized over the human's capacity to understand and judge.

### 13. Code is disposable, understanding is not

It is more efficient to regenerate code from clear context and passing tests than to maintain code nobody understands. Two implementations are equivalent as long as they arise from the same context and pass the same tests. The system owns the ability to regenerate, not the code itself.

---

## The Cognitive Triad

Westphal reframes pair programming as a cognitive triad: Customer — Developer — Model.

- **Customer** provides problem understanding, makes value decisions, evaluates experiments
- **Developer** ensures system structure, context, integration, and architectural coherence
- **Model** handles implementation, exploration, and generation

In practice, the human wears both Customer and Developer hats. The skill makes the active perspective visible through lightweight triad indicators — navigation aids that fade into intuition over time.

### Triad Indicators

A context line shown at phase entry and when the dominant perspective shifts mid-phase:

```
[Customer] — problem understanding driving
[Developer] — system structure driving
[Model] — exploration/generation driving
[Customer + Developer] — evaluating together
[Customer + Developer + Model] — full triad sync
```

Never explained or narrated — just present as a marker. The human internalizes the pattern over time; the labels are scaffolding, not process.

### Triad Tension as Mechanism

The tension between perspectives is what produces collective intelligence. When Customer perspective dominates too long without Developer pushback, or when Model generates without Customer validation, the skill notices and rebalances. The triad is not a label — it is the mechanism for avoiding echo chambers.

---

## Phase Structure

Every invocation of `/xp` begins at Phase 01. The skill moves through phases in order but can loop back when understanding degrades. Each phase lives in its own file under `xp/phases/`.

### Phase 01 — Synchronize

**Purpose:** Establish the triad's shared mental model before doing anything.

**What happens:**
- Read primary artifacts: hypothesis log, specs, code, tests, git log
- Reconstruct understanding from ground truth — never trust summaries, always verify against actual state
- If artifacts exist: summarize current state, surface the active hypothesis, confirm shared understanding with the human
- If no artifacts exist: this is a fresh start — transition to Discover

**Triad:** [Customer + Developer + Model] — all three perspectives needed to establish common ground

**Exit criteria:** The triad agrees on where we are and what we know.

**Context anchoring:** This phase IS the re-anchoring mechanism. The skill reconstructs its understanding from primary artifacts (hypothesis log, tests, code, git log) rather than trusting any intermediate summary. This happens on every `/xp` invocation. Within long sessions, the skill triggers a lightweight re-anchor when: (a) a phase transition occurs, (b) the hypothesis is updated or invalidated, or (c) the skill detects its own output contradicts a primary artifact. These are concrete, observable triggers — not time-based guesses about context decay.

### Phase 02 — Discover

**Purpose:** Formulate the problem. Understand what we're building and why. Form hypotheses.

**What happens:**
- Ask clarifying questions one at a time (prefer multiple choice)
- Understand purpose, constraints, success criteria
- Challenge assumptions — actively guard against confirmation bias
- Frame the work as a hypothesis: "We believe [X] will [Y] for [Z]"
- Assess scope: if too large, decompose into sub-projects first
- Record hypothesis in the persistent log

**Triad:** [Customer] dominant — problem understanding drives this phase

**Exit criteria:** A clear, falsifiable hypothesis exists. The problem is understood well enough to explore solutions.

### Phase 03 — Explore

**Purpose:** Build understanding of the solution space before committing. Depth scales with unfamiliarity.

**What happens:**
- Assess: how familiar is this territory? Scale exploration accordingly
- In unfamiliar territory: spike solutions, disposable prototypes, multiple variations explored in parallel
- In familiar territory: lighter exploration, possibly just 2-3 approaches with trade-offs
- Propose approaches with a recommendation — generate genuine alternatives, not variations of the human's first idea
- Resist building too early — this phase exists to prevent premature commitment
- All code generated here is disposable by definition

**Triad:** [Model] dominant — the model explores, the human selects

**Exit criteria:** The triad has enough understanding to make a design decision. Possibilities have been discarded, not just generated.

### Phase 04 — Design

**Purpose:** Define the architecture through radical simplicity and the shared mental model.

**What happens:**
- Present design section by section, scaled to complexity
- Apply radical simplicity as a filter — actively remove unnecessary abstraction
- Establish or update the system metaphor / shared mental model
- Define bounded contexts and structural boundaries
- Design is evolutionary, not predictive — just enough for the current work
- Validate design against the hypothesis: does this structure serve what we're trying to learn?

**Triad:** [Developer] dominant — system structure and context drive this phase

**Exit criteria:** The triad agrees on the design. Structure is narratable and collectively manageable.

### Phase 05 — Plan

**Purpose:** Break the design into buildable steps, each a potential learning opportunity.

**What happens:**
- Decompose design into implementation steps
- Each step should be independently testable and deliverable
- Identify which steps are micro-experiments (hypothesis-testing) vs. mechanical (known work)
- Define or update machine-enforceable design rules: coding conventions, structural rules, naming patterns
- Enforce constraints — what are we deliberately NOT building?

**Triad:** [Developer + Model] — developer provides structure, model helps decompose

**Exit criteria:** A concrete sequence of steps exists. Each step has clear behavior to implement and test.

### Phase 06 — Build

**Purpose:** Implement through behavior-first engineering (TDD). Reconstruct with understanding.

**What happens:**
- Write tests first — tests are the control interface
- Generate code to satisfy tests
- Follow the reconstructive pattern: if exploration was done in Phase 03, rebuild deliberately here
- Apply coding standards as machine-enforceable design
- Continuous assimilation after every step — proportional to change magnitude:
  - Small edit: light coherence check (does this still fit?)
  - Significant addition: deeper structural review (does the architecture still hold?)
- If understanding degrades, stop and return to an earlier phase

**Triad:** [Model] dominant for generation, [Developer] for assimilation decisions

**Exit criteria:** Tests pass. Code is assimilated into the architecture. The triad understands what was built and why.

### Phase 07 — Verify

**Purpose:** Continuous system verification. CI as the immune system.

**What happens:**
- Run the full test suite, not just new tests
- Check for probabilistic drift: do system-level properties still hold?
- Verify structural coherence: does the codebase still match the shared mental model?
- Verify conformance: does the code satisfy the design rules?
- Limit blast radius: confirm changes are contained within their bounded context
- Gate: the system is "understood and ready for integration" — not just "tests pass"

**Triad:** [Developer + Model] — model runs verification, developer judges coherence

**Exit criteria:** System integrity confirmed. No drift detected. The triad can explain every change.

### Phase 08 — Review

**Purpose:** Radical code transparency. Ensure the triad can collectively understand what exists.

**What happens:**
- Transparency check: can someone who wasn't present understand this code's structure and intent without the author explaining it?
- Consistency check: does the code conform to the design rules?
- Simplicity check: is this the simplest possible implementation?
- Mental model check: does the code match the shared mental model and system metaphor?
- Actively look for what might be wrong — invert the default from "looks good" to "what could break?"

**Triad:** [Customer + Developer] — can both the technical and non-technical perspective make sense of this?

**Exit criteria:** The triad confirms radical code transparency. No black boxes. No unexamined assumptions.

### Phase 09 — Deliver

**Purpose:** Ship as a micro-experiment. Learn from reality.

**What happens:**
- Frame the delivery as a hypothesis test: "We predicted [X]. Let's see."
- Ship the smallest increment that tests the hypothesis
- Observe: what did we learn? Was the hypothesis confirmed or invalidated?
- Update the hypothesis log (forward-moving — don't rewrite, record)
- Decision: continue building on this, pivot based on learning, or stop?

**Triad:** [Customer] dominant — the customer evaluates whether the experiment succeeded

**Exit criteria:** Learning is recorded. The next cycle begins from Synchronize with updated understanding.

### Phase Flow

```
Synchronize -> Discover -> Explore -> Design -> Plan -> Build -> Verify -> Review -> Deliver
     ^                                                                                 |
     |_________________________________________________________________________________|
                              (next cycle starts from Synchronize)

Any phase can loop back to an earlier phase when understanding degrades.
```

---

## The Hypothesis Log

The persistent thinking process — the triad's shared memory across sessions.

### Structure

Each entry is forward-moving. Never rewritten, never deleted. The log tells the story of what the triad believed, what it learned, and how that changed direction.

```markdown
# Hypothesis Log — [Project Name]

## Active Hypothesis
> We believe [X] will [Y] for [Z].

## Log

### [YYYY-MM-DD] — Entry title
**Phase:** [which phase generated this entry]
**Triad:** [which perspective was dominant]
**Status:** hypothesis | exploring | validated | invalidated | pivoted

[What we believed]

[What we did]

[What we learned]

[What changes as a result — next step, new constraint, updated direction]
```

### Rules

1. **Forward-only** — invalidated hypotheses stay in the log. They are learnings, not mistakes.
2. **One active hypothesis at a time** — if work spans multiple hypotheses, decompose into sub-projects. Each gets its own cycle.
3. **Every meaningful deliverable gets an entry** — mechanical commits don't. The test: did this change what we understand?
4. **Phase transitions get entries** — when the skill decides to loop back to an earlier phase, that decision and its reasoning are recorded.
5. **The log is the synchronization source** — when `/xp` is invoked, Phase 01 (Synchronize) reads this log to rebuild the triad's shared understanding.

### Where It Lives

`docs/xp/hypothesis-log.md` in the project root. One per project. The skill creates it during the first Discover phase if it doesn't exist.

---

## Cognitive Load Self-Regulation

The skill monitors its own demand on human attention and adjusts without being asked.

### Signals the Skill Watches For

- **Decision density** — how many choices has it asked for in the last few exchanges?
- **Context switches** — is it jumping between different concerns within a single message?
- **Complexity** — is the human being asked to evaluate something that requires holding many things in mind at once?

### How It Adjusts

- **Batch related decisions** — if three naming questions arise in sequence, group them into one multiple-choice question
- **Sequence heavy decisions** — don't stack an architecture decision immediately after a scope decision
- **Simplify framing** — lead with the recommendation and reasoning; the human digs deeper if they want
- **Break large phases** — present progress incrementally rather than front-loading the full plan
- **Never rush phase transitions** — pauses naturally at phase boundaries, confirming understanding before proceeding

### What It Never Does

- Asks "are you overwhelmed?" — that itself adds cognitive load
- Explains that it's managing pace — the management is invisible
- Slows down artificially when the human is in flow

---

## Context Anchoring

The model's context can drift the same way code can. The skill treats its own understanding as something that must be verified against ground truth, not trusted from memory.

### Mechanism

On every re-anchor (invocation or mid-session), the skill reconstructs understanding from primary artifacts:

1. **Hypothesis log** — what do we believe, what have we learned? (forward-only, append-only — trustworthy by construction)
2. **Spec/design** — what did we decide to build?
3. **Git log** — what was actually committed?
4. **Tests** — does the system behave as expected? (they pass or they don't — objective)
5. **Code** — does it match the mental model?

No intermediate summary files. The primary artifacts are the truth. The re-anchoring IS a lightweight version of Phase 01 (Synchronize).

---

## Machine-Enforceable Design

### How It Works

During Phase 05 (Plan), the skill establishes or reads the project's design rules. These are structural constraints that prevent generated code from losing coherence.

**Two sources:**

1. **Project-level rules** — discovered from the existing codebase during Synchronize. The skill reads existing patterns, conventions, and architecture to infer the active standards. Verified against ground truth, not assumed.
2. **Declared rules** — explicitly defined in `docs/xp/design-rules.md`. Created during the first Design phase if it doesn't exist. Updated when the shared mental model evolves.

### What Gets Enforced

```markdown
# Design Rules — [Project Name]

## Structural Boundaries
- [Which modules/contexts exist and their responsibilities]
- [What depends on what — and what must NOT depend on what]

## Naming & Language
- [Domain vocabulary — the system metaphor in concrete terms]
- [Naming conventions that encode architectural intent]

## Patterns
- [How we handle X in this codebase — the specific patterns this project uses]

## Constraints
- [What we deliberately do NOT do — YAGNI boundaries]
```

### When Enforcement Happens

- **During Build** — generated code is checked against design rules before assimilation
- **During Verify** — the full system is verified against rules, catching drift
- **During Review** — design rules are part of the consistency check (separate from the transparency check)

### How Rules Evolve

Rules change when the shared mental model changes. Changes are deliberate:

1. A rule violation is detected or a new pattern emerges
2. The skill surfaces it: "This contradicts design rule X. Should we update the rule or change the code?"
3. If the rule updates, it's recorded in the hypothesis log as a learning
4. The updated rule applies going forward — no retroactive enforcement

---

## Confirmation Bias Countermeasures

### The Problem

AI amplifies confirmation bias. Critical reflection can decrease. False assumptions scale faster than ever. The triad exists partly as a counterweight — but only if the tension between perspectives is maintained.

### How the Skill Counteracts This

**Devil's advocate at decision points.** At moments where the triad commits to a direction, the skill briefly argues the other side: "What would have to be true for this to be wrong?" If the human has a ready answer, move on. If it reveals uncertainty, explore it.

**Hypothesis framing forces falsifiability.** Every hypothesis is structured as a belief that can be proven wrong. If it can't be falsified, it's not a hypothesis — it's an assumption hiding as one. The skill pushes until hypotheses are testable.

**Exploration surfaces alternatives, not just validation.** During Explore, the skill generates genuine alternatives — approaches the human might not have considered. The human selects from a real spread, not from variations of their first idea.

**Review looks for what's wrong, not what's right.** The Review phase inverts the default: instead of "this looks good," it asks "what could be wrong here?"

**Triad tension is the mechanism.** The triad indicators signal which perspective is driving. When one perspective dominates too long without counterbalance, the skill notices and rebalances.

### What It Never Does

- Argues for the sake of arguing — if a decision is sound, it moves on
- Blocks progress with artificial doubt
- Announces "I'm now playing devil's advocate" — the challenge is woven in naturally

---

## Distribution

### Repository Structure

```
xp/
  xp.md                        # Core: philosophy, triad, synchronization, phase routing
  phases/
    01-synchronize.md
    02-discover.md
    03-explore.md
    04-design.md
    05-plan.md
    06-build.md
    07-verify.md
    08-review.md
    09-deliver.md
  templates/
    hypothesis-log.md
    design-rules.md
  README.md
  LICENSE
```

### Installation

```bash
npx skills add owner/xp
```

### README Approach

The README explains what `/xp` is and links to Westphal's article. It does not reference other skills or position itself as a replacement. The philosophy is self-explanatory.

### Contribution Model

The skill is opinionated — it embeds a specific philosophy. Contributions serve the framework, not dilute it.

**Welcome:** Improvements to phases, fixes where behavior contradicts principles, new learnings from applying XP-in-AI.

**Not welcome:** Optional modes that let users skip phases, making principles configurable, adding alternative philosophies alongside XP.

The article is the source of truth for directional disagreements. The skill evolves as the thinking evolves, but stays rooted.

---

## Invocation

`/xp` accepts a plain-language description of what to work on:

```
/xp build a notification system for our app
/xp fix the race condition in the payment flow
/xp explore whether we should migrate to postgres
```

No subcommands. No phase selection. Always starts from Synchronize. Understanding is fast when there's already a lot to build on.

---

## Westphal Shift Coverage

Every row in the article's shift table is accounted for:

| XP Shift | Where in this design |
|---|---|
| Cognitive Triad | Triad indicators, present in every phase |
| Radical Code Transparency | Principle 8, Review phase |
| Behavior-First Engineering | Principle 2, Build phase |
| Continuous System Verification | Verify phase |
| Continuous Assimilation | Principle 4, built into every Build step |
| Radical Simplicity | Principle 10, Design phase |
| Shared Mental Model | Principle 3, Design phase, hypothesis log |
| Machine-Enforceable Design | Principle 9, Plan + Build + Verify |
| Customer-Driven Discovery | Discover phase |
| Continuous Discovery Loop | Full phase cycle, hypothesis log |
| Micro-Experiments | Deliver phase |
| Sustainable Cognitive Load | Principle 12, cognitive load self-regulation |

New patterns from the article (Disposable Code, Reconstructive Programming, Exploration at Scale) are in Principle 5 and the Explore + Build phases.
