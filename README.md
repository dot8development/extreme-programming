# /xp — Extreme Programming in the Age of AI

A development skill that implements the full software development lifecycle as a unified workflow. Model-agnostic — works with any coding agent or LLM.

Grounded in Frank Westphal's [Extreme Programming in the Age of AI](https://frankwestphal.de/ExtremeProgrammingintheAgeofAI.html).

## Install

```bash
npx skills add dot8development/extreme-programming
```

## Use

```
/xp build a notification system for our app
/xp fix the race condition in the payment flow
/xp explore whether we should migrate to postgres
```

`/xp` is the single entry point for all development work. No subcommands. It guides you through the full lifecycle: synchronize → discover → explore → design → plan → build → verify → review → deliver.

## Core Mission

**Keep the cost of understanding low.**

In a world where code generation is cheap, understanding and judgment become the scarcest resources. This skill protects those resources through a system of reinforcing practices — tight feedback loops, behavior-first engineering, continuous assimilation, radical simplicity, and persistent decision records.

Code is disposable. Understanding is not.

## The Cognitive Triad

Every phase operates within a triad of perspectives: **Customer** (problem understanding) — **Developer** (system structure) — **Model** (exploration and generation). The tension between these perspectives produces collective intelligence.

## Contributing

This skill is opinionated. It embeds a specific philosophy grounded in the article linked above.

**Welcome:** Improvements to phases, fixes where behavior contradicts principles, new learnings from applying XP with AI.

**Not welcome:** Optional modes that let users skip phases, making principles configurable, alternative philosophies alongside XP.

## License

MIT
