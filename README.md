# Skills

[English](README.md) | [繁體中文](README.zh-TW.md)

Reusable agent skills and shared collaboration rules. Skills load when relevant; shared rules provide guidance at the start of each session. Install them separately.

## Repository structure

```text
rules/collaboration.md           Shared English rules (single source)
scripts/Install-Rules.ps1        User-level rule installer
<skill-name>/SKILL.md            Independently installable skills
README.md / README.zh-TW.md      English / Traditional Chinese documentation
```

Shared rules are not stored as root CLAUDE.md or AGENTS.md templates, so copying a template over an existing project's instructions is unnecessary.

## Install skills

Requires Node.js 22.20 or later, npm, and Git. Install all skills globally for both Claude Code and Codex:

```sh
npx skills add allenstu6311/Skills --skill '*' -g -a claude-code -a codex
```

Global installation makes skills available across projects for your account. Use only `-a codex` or `-a claude-code` to target one agent. Omit agent flags to select agents interactively. Omit `-g` to install into the current project instead.

Install one skill or preview discovery without installing:

```sh
npx skills add allenstu6311/Skills --skill requirements-to-domain -g -a codex
npx skills add allenstu6311/Skills --list
```

On Windows PowerShell, use `npx.cmd` if execution policy blocks `npx.ps1`. These commands install skills only; they do not install `rules/collaboration.md`.

## Install shared rules

Clone this repository once per machine, then run the installer in PowerShell 5.1 or later:

```powershell
git clone https://github.com/allenstu6311/Skills.git
Set-Location Skills
.\scripts\Install-Rules.ps1 -Agent both
```

Use `-Agent claude-code` or `-Agent codex` to install rules for only one agent. Add `-WhatIf` to preview writes. If Windows blocks the script, review its contents and run it with a process-only bypass:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\scripts\Install-Rules.ps1 -Agent both
```

| Agent | Default destination | Existing content |
| --- | --- | --- |
| Claude Code | `~/.claude/rules/allenstu-collaboration.md` | Leaves personal CLAUDE.md and other rules untouched. Backs up this destination before replacing changed content. |
| Codex | `~/.codex/AGENTS.md` | Appends a managed block, or updates that block on later runs. Preserves content outside the block and backs up changed files. |

`~` means your user home directory. The installer respects `CLAUDE_CONFIG_DIR` and `CODEX_HOME`; `-ClaudeHome` and `-CodexHome` can override those paths. It never edits project files. New and existing projects receive the user-level rules on a new agent session. Project instructions also load; keep them consistent with shared rules.

A nonempty global `AGENTS.override.md` takes precedence over Codex's AGENTS.md. The installer refuses the Codex step when that override exists. If installing both agents, the Claude step may already have completed.

### Migrating earlier copies

If you previously copied these principles into personal CLAUDE.md or AGENTS.md, review and remove only that duplicate section after installing. Keep unrelated instructions. The installer does not automatically remove or translate older text; an exact English copy in Codex AGENTS.md is wrapped in the managed markers instead of duplicated.

To uninstall, remove Claude's `allenstu-collaboration.md` and/or only the Codex block between `<!-- allenstu6311/Skills:begin -->` and `<!-- allenstu6311/Skills:end -->`. Backups use a `.bak` suffix beside the changed file.

## Available skills

| Skill | When to use it |
| --- | --- |
| [requirements-to-domain](requirements-to-domain/SKILL.md) | Clarify scattered software requirements into a specification for subsequent OOAD. |
| [domain-to-ooad](domain-to-ooad/SKILL.md) | Explicitly request selected editable draw.io class, sequence, or activity diagrams from requirements. Requires access to compatible draw.io tools. |
| [code-fault-tree](code-fault-tree/SKILL.md) | Trace an operation through failure symptoms, causes, and actual handling found in code. |
| [design-decision](design-decision/SKILL.md) | Assess design-pattern tradeoffs at relevant change points, or discuss and review pattern choices. |
| [discuss-architecture](discuss-architecture/SKILL.md) | Evaluate responsibility boundaries, state ownership, dependencies, lifecycle, and migration tradeoffs using system evidence. |

## Updates and local development

Update globally installed skills from their published sources:

```sh
npx skills update -g
```

Update shared rules separately, from this checkout:

```powershell
git pull
.\scripts\Install-Rules.ps1 -Agent both
```

GitHub skill installs use the published repository version. Local edits are not distributed until committed and pushed. Installed copies and rules do not automatically track edits in this checkout. Re-run the appropriate installer after updates.

Preview skills from local edits without installing:

```sh
npx skills add . --list
```

Each skill keeps its own supporting references inside its directory. Skill instructions and shared rules are written in English; output language follows the request and each skill's guidance.

## Repository maintenance

After changing skills or installation behavior, check both READMEs against the final changes. Keep skill listings, scope, prerequisites, links, and commands consistent. Internal changes do not require a README edit when documentation remains accurate. This is a maintenance convention, not an automated hook or CI check.

Sources: [skills CLI](https://github.com/vercel-labs/skills), [Claude memory and rules](https://code.claude.com/docs/en/memory), [Codex AGENTS.md](https://learn.chatgpt.com/docs/agent-configuration/agents-md).
