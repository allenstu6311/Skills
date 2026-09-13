# Skills

[English](README.md) | [繁體中文](README.zh-TW.md)

A collection of agent skills that can be installed and reused across projects.

## Installation

Requires Node.js, npm, and Git. Run from any directory to install all skills globally for Codex:

```sh
npx skills add allenstu6311/Skills --skill '*' -g -a codex
```

Global installation makes the skills available across projects for your user account. You do not need to copy them into each project. To select another supported agent interactively, omit `-a codex`.

Install only the requirements skill:

```sh
npx skills add allenstu6311/Skills --skill requirements-to-domain -g -a codex
```

Preview available skills without installing:

```sh
npx skills add allenstu6311/Skills --list
```

On Windows PowerShell, use `npx.cmd` instead of `npx` if script execution policy blocks `npx.ps1`.

## Available skills

| Skill | When to use it |
| --- | --- |
| [requirements-to-domain](requirements-to-domain/SKILL.md) | Organize and clarify scattered software requirements into a specification for subsequent OOAD. |
| [domain-to-ooad](domain-to-ooad/SKILL.md) | Explicitly request editable draw.io class, sequence, or activity diagrams from requirements. |
| [code-fault-tree](code-fault-tree/SKILL.md) | Trace an operation through failure symptoms, causes, and actual handling found in code. |
| [design-decision](design-decision/SKILL.md) | Assess whether a code change warrants a design pattern, or discuss and review pattern choices. |

## Updates

Update installed skills from their published sources:

```sh
npx skills update
```

GitHub installs use the version published to the repository. Local edits in this checkout are not distributed until committed and pushed. Installed skills do not automatically track edits in this checkout.

## Local development

Preview skill discovery from this checkout:

```sh
npx skills add . --list
```

Each skill has its own directory containing `SKILL.md` and any supporting references. Keep references inside that directory so the skill can be installed independently.

Installation and CLI options: [skills CLI documentation](https://github.com/vercel-labs/skills).

## Repository maintenance

After changing skills or installation behavior, check both README.md and README.zh-TW.md against the final changes and update any affected skill listings, usage descriptions, links, prerequisites, or commands. Keep the English and Traditional Chinese versions consistent. Internal changes do not require a README edit when the documentation remains accurate.

This is a documentation maintenance convention, not an automated hook or CI check.
