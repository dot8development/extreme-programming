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

The skill ships seven opt-in hooks that convert the highest-risk rules from prose discipline into deterministic enforcement. They only activate in projects that have a `docs/xp/` directory — non-/xp projects are unaffected.

| Hook | Event | What it does |
|---|---|---|
| `anchor.sh` | UserPromptSubmit | On `/xp` invocation, prepends an anchoring reminder that Phase 01 (Synchronize) must run before responding. *(injection)* |
| `offload-detect.sh` | UserPromptSubmit | Scans user message for offload phrases (trust/authority/permission/passive). Injects Strike-1 trigger when detected. *(injection)* |
| `test-first.sh` | PreToolUse (Write/Edit) | Blocks writes to source paths unless a test file was touched recently. Enforces Phase 06 Iron Law. |
| `hypothesis-first.sh` | PreToolUse (Write/Edit) | Blocks writes to source paths if `docs/xp/hypothesis-log.md` is missing. |
| `explore.sh` | PreToolUse (Grep/Glob/WebFetch/WebSearch) | Blocks exploration tools in the main agent. Forces sub-agent dispatch. Read stays allowed (Edit needs it). |
| `sonnet.sh` | PreToolUse (Task/Agent) | Blocks Task dispatches with `model="haiku"`. Enforces Sonnet-minimum. |
| `return-format.sh` | PostToolUse (Task/Agent) | Validates sub-agent returns contain `Finding:` + `Sources:`. Injects re-dispatch instruction on malformed returns. *(injection)* |

Blocked hooks exit 2 — the harness surfaces stderr back to the model so it fixes the underlying violation. Do not disable hooks. Fix the violation.

**Two hook types.** `anchor.sh` is an *injection hook* — it prepends a reminder on `/xp` invocation. It writes to stdout by design. The other two are *gate hooks* — silent on success, exit 2 on violation. Don't apply the "silent success" rule to anchor; it's the rule's only deliberate exception.

**Throw-away discipline.** Hooks are not sacred. If a hook produces noise without preventing real failures, retire it. The skill ships with three because the failures they catch are observed (Phase 01 skip, code-before-test, code-without-hypothesis). If one isn't earning its keep on your project, remove it from your settings.json.

**Design hooks the same way.** Before adding a custom hook on top of these three: confirm the failure is real, write the hook, test it on the failure, observe whether it actually prevents recurrence, and only then keep it. Add hooks (and skills, and MCP servers) on observed failure — never speculatively. Speculative installation costs context budget without earning anything.

### Install

Hook scripts live at `~/.claude/skills/xp/hooks/` after `npx skills add`. Wire them into your harness:

<details>
<summary><b>Claude Code</b> — <code>~/.claude/settings.json</code></summary>

```json
{
  "hooks": {
    "UserPromptSubmit": [
      { "hooks": [
          { "type": "command", "command": "bash ~/.claude/skills/xp/hooks/anchor.sh" },
          { "type": "command", "command": "bash ~/.claude/skills/xp/hooks/offload-detect.sh" }
      ]}
    ],
    "PreToolUse": [
      { "matcher": "Write|Edit|MultiEdit", "hooks": [
          { "type": "command", "command": "bash ~/.claude/skills/xp/hooks/test-first.sh" },
          { "type": "command", "command": "bash ~/.claude/skills/xp/hooks/hypothesis-first.sh" }
      ]},
      { "matcher": "Grep|Glob|WebFetch|WebSearch", "hooks": [
          { "type": "command", "command": "bash ~/.claude/skills/xp/hooks/explore.sh" }
      ]},
      { "matcher": "Task|Agent", "hooks": [
          { "type": "command", "command": "bash ~/.claude/skills/xp/hooks/sonnet.sh" }
      ]}
    ],
    "PostToolUse": [
      { "matcher": "Task|Agent", "hooks": [
          { "type": "command", "command": "bash ~/.claude/skills/xp/hooks/return-format.sh" }
      ]}
    ]
  }
}
```
Restart Claude Code.
</details>

<details>
<summary><b>Codex CLI</b> — <code>~/.codex/hooks.json</code> + <code>codex_hooks = true</code> in <code>config.toml</code></summary>

```json
{
  "version": 1,
  "hooks": {
    "UserPromptSubmit": [{ "type": "command", "command": "bash ~/.claude/skills/xp/hooks/anchor.sh" }],
    "PreToolUse": [
      { "matcher": "Write|Edit", "type": "command", "command": "bash ~/.claude/skills/xp/hooks/test-first.sh" },
      { "matcher": "Write|Edit", "type": "command", "command": "bash ~/.claude/skills/xp/hooks/hypothesis-first.sh" }
    ]
  }
}
```
Same exit-code-2 contract as Claude Code; scripts work as-is.
</details>

<details>
<summary><b>Cursor</b> — <code>.cursor/hooks.json</code> (project) or <code>~/.cursor/hooks.json</code> (user)</summary>

```json
{
  "version": 1,
  "hooks": {
    "beforeSubmitPrompt": [{ "command": "bash ~/.claude/skills/xp/hooks/anchor.sh" }],
    "preToolUse": [
      { "matcher": { "tool": "edit_file" }, "command": "bash ~/.claude/skills/xp/hooks/test-first.sh" },
      { "matcher": { "tool": "edit_file" }, "command": "bash ~/.claude/skills/xp/hooks/hypothesis-first.sh" }
    ]
  }
}
```
Cursor uses exit code 2 to block; scripts work as-is.
</details>

<details>
<summary><b>Windsurf (Cascade)</b> — <code>.windsurf/hooks.json</code></summary>

```json
{
  "version": 1,
  "hooks": {
    "pre_user_prompt": [{ "command": "bash ~/.claude/skills/xp/hooks/anchor.sh" }],
    "pre_write_code": [
      { "command": "bash ~/.claude/skills/xp/hooks/test-first.sh" },
      { "command": "bash ~/.claude/skills/xp/hooks/hypothesis-first.sh" }
    ]
  }
}
```
Caveat: Windsurf has no documented context-injection from hooks, so anchor.sh's reminder text may not reach the model. The gate hooks (test-first / hypothesis-first) work via exit code 2.
</details>

<details>
<summary><b>GitHub Copilot</b> (Cloud Agent + VS Code) — <code>.github/hooks/hooks.json</code> (must be on default branch for Cloud Agent)</summary>

```json
{
  "version": 1,
  "hooks": {
    "userPromptSubmitted": [{ "command": "bash ~/.claude/skills/xp/hooks/anchor.sh" }],
    "preToolUse": [
      { "matcher": { "toolName": "edit_file" }, "command": "bash ~/.claude/skills/xp/hooks/test-first.sh" },
      { "matcher": { "toolName": "edit_file" }, "command": "bash ~/.claude/skills/xp/hooks/hypothesis-first.sh" }
    ]
  }
}
```
Copilot prefers JSON `permissionDecision: "deny"` over exit code 2 — scripts may need a thin wrapper that converts exit 2 + stderr into a JSON `{"permissionDecision":"deny","reason":"<stderr>"}`. Status: untested. PRs welcome.
</details>

<details>
<summary><b>Cline</b> — <code>~/Documents/Cline/Hooks/</code> (global) or <code>.clinerules/hooks/</code> (project)</summary>

```json
{
  "version": 1,
  "hooks": {
    "UserPromptSubmit": [{ "command": "bash ~/.claude/skills/xp/hooks/anchor.sh" }],
    "PreToolUse": [
      { "matcher": "write_to_file|replace_in_file", "command": "bash ~/.claude/skills/xp/hooks/test-first.sh" },
      { "matcher": "write_to_file|replace_in_file", "command": "bash ~/.claude/skills/xp/hooks/hypothesis-first.sh" }
    ]
  }
}
```
Cline blocks via JSON `{"cancel": true}` rather than exit 2 — scripts may need a thin wrapper. macOS/Linux only. Status: untested. PRs welcome.
</details>

<details>
<summary><b>Aider / Continue.dev</b> — no hook system</summary>

These harnesses have no PreToolUse / UserPromptSubmit hook mechanism. The skill markdown still works; you'll rely on prose discipline rather than deterministic enforcement.
</details>

Hooks activate only when a `docs/xp/` directory exists in the project — non-/xp projects are unaffected on every harness.

## Contributing

This skill is opinionated. It embeds a specific philosophy grounded in the article linked above.

**Welcome:** Improvements to phases, fixes where behavior contradicts principles, new learnings from applying XP with AI.

**Not welcome:** Optional modes that let users skip phases, making principles configurable, alternative philosophies alongside XP.

## License

MIT
