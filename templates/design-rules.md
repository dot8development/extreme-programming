# Design Rules — [Project Name]

Structural constraints that prevent generated code from losing coherence. These are control signals for generative code — the system prompt of the repository.

Rules evolve deliberately: violation detected → surface it → update rule or change code → record in hypothesis log.

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
