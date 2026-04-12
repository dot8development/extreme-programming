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

## The Triad Is Non-Negotiable

/xp requires you to hold the Customer and Developer roles. The model handles exploration and implementation — it does not make customer or developer decisions, and it will refuse if you try to offload them.

If you want a skill where the model decides direction, architecture, or success for you, /xp is not the right choice. Use a different tool.

This is opinionated on purpose. The skill only produces collective intelligence when the triad is intact.

## Optional: Enforcement Hooks

The skill ships three opt-in Claude Code hooks that convert the highest-risk rules from prose discipline into deterministic enforcement. They only activate in projects that have a `docs/xp/` directory — non-/xp projects are unaffected.

| Hook | Event | What it does |
|---|---|---|
| `anchor.sh` | UserPromptSubmit | On `/xp` invocation, prepends an anchoring reminder that Phase 01 (Synchronize) must run before responding. |
| `test-first.sh` | PreToolUse (Write/Edit) | Blocks writes to `src/`, `lib/`, `app/`, `pkg/`, `internal/`, `cmd/` unless a test file was touched in the recent session. Enforces Phase 06 Iron Law: no production code without a failing test first. |
| `hypothesis-first.sh` | PreToolUse (Write/Edit) | Blocks writes to source paths if `docs/xp/hypothesis-log.md` doesn't exist. Enforces that code follows a recorded hypothesis. |

Blocked hooks exit 2 — the harness surfaces stderr back to the model so it fixes the underlying violation. Do not disable hooks. Fix the violation.

### Install

After `npx skills add`, the hook scripts live at `~/.claude/skills/xp/hooks/` (or wherever the skill was installed). Add to your `~/.claude/settings.json`:

```json
{
  "hooks": {
    "UserPromptSubmit": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "bash ~/.claude/skills/xp/hooks/anchor.sh"
          }
        ]
      }
    ],
    "PreToolUse": [
      {
        "matcher": "Write|Edit|MultiEdit",
        "hooks": [
          {
            "type": "command",
            "command": "bash ~/.claude/skills/xp/hooks/test-first.sh"
          },
          {
            "type": "command",
            "command": "bash ~/.claude/skills/xp/hooks/hypothesis-first.sh"
          }
        ]
      }
    ]
  }
}
```

Restart Claude Code. Hooks will activate only when a `docs/xp/` directory exists in your project.

## Contributing

This skill is opinionated. It embeds a specific philosophy grounded in the article linked above.

**Welcome:** Improvements to phases, fixes where behavior contradicts principles, new learnings from applying XP with AI.

**Not welcome:** Optional modes that let users skip phases, making principles configurable, alternative philosophies alongside XP.

## License

MIT
