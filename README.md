# Agent Toolkit

Source of truth for personal agent tooling across devices and coding harnesses.

## Current Layout

```text
global/
  claude/CLAUDE.md
  codex/AGENTS.md
skills/
  plan-tasks/
  reorient/
git/
  commit-guard/
```

Shared behavior should remain general. Harness-specific files should contain only genuine differences.

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
- [ ] Inventory and isolate harness-specific skills.
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
