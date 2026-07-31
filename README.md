# Agent Toolkit

Source of truth for personal agent tooling across devices and coding harnesses.

## Current Layout

```text
global/
  claude/CLAUDE.md
  codex/AGENTS.md
skills/
  deprecated/
git/
  commit-guard/
```

Shared behavior should remain general. Harness-specific files should contain only genuine differences.

## Skills

All skills are user-invoked only — `disable-model-invocation: true` for Claude, `policy.allow_implicit_invocation: false` for Codex.

| Stage | Skills |
| --- | --- |
| Explore | `reorient` |
| Design | `grill-me`, `grill-with-docs`, `grilling`, `domain-modeling`, `prototype`, `codebase-design`, `improve-codebase-architecture` |
| Plan | `wayfinder`, `to-spec`, `to-tickets`, `plan-tasks`, `triage` |
| Build | `implement`, `burn-tickets`, `tdd`, `code-review`, `diagnosing-bugs`, `resolving-merge-conflicts` |
| Meta | `setup-skills`, `handoff`, `writing-great-skills` |

Most originate from [mattpocock/skills](https://github.com/mattpocock/skills) (MIT). `reorient` and `plan-tasks` are mine. Replaced skills move to `skills/deprecated/`.

Run the `/setup-skills` skill once per repo before the others — it records the issue tracker, triage labels, and doc layout under `docs/agents/`.

## Git Commit Guard

Install or update the global guard:

```powershell
.\git\commit-guard\install.ps1
```

Run its isolated and real-commit tests:

```powershell
.\git\commit-guard\tests\run.ps1
```

## Target Stacks

- Frontend: Vite, React, and TypeScript.
- Work backend: Django.
- Personal backend: Go, with occasional FastAPI.
- Tooling and scripts: primarily Go, with occasional Python.

## Roadmap

- [x] Add global Claude and Codex instructions.
- [x] Remove Claude-specific language from Codex instructions.
- [x] Add shared global skills.
- [x] Inventory and isolate harness-specific skills.
- [ ] Maybe: record verifier commands per repo, if "run the full test suite" proves too vague.
- [ ] Add a `ship` skill (push, PR with `Closes #N`, auto-merge) once needed.
- [ ] Maybe: symlink installer for `skills/` so the repo is the live copy. Copying works for now.
- [ ] Add shared hook scripts and thin harness adapters.
- [x] Add the global Git commit guard, denylist, and tests.
- [ ] Add guardrail presets for React/TypeScript, Django, FastAPI, and Go.
- [ ] Add tested Semgrep rules for high-confidence structural policies.
- [ ] Add CI templates and protected-check guidance.
- [ ] Add install, update, drift-check, and backup scripts.

## Principles

- Keep one canonical source whenever behavior is shared.
- Prefer native, dependency-free tooling until a framework earns its cost.
- Keep project-specific versions and configuration in each project.
- Enforce important rules in CI; local hooks are only a fast backstop.
- Never commit credentials, histories, caches, or generated machine state.
