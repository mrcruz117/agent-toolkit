# Agent Toolkit

Source of truth for personal agent tooling across devices and coding harnesses.

## Current Layout

```text
global/
  claude/CLAUDE.md
  codex/AGENTS.md
```

Shared behavior should remain general. Harness-specific files should contain only genuine differences.

## Roadmap

- [x] Add global Claude and Codex instructions.
- [x] Remove Claude-specific language from Codex instructions.
- [ ] Add shared global skills.
- [ ] Inventory and isolate harness-specific skills.
- [ ] Add shared hook scripts and thin harness adapters.
- [ ] Add the global Git commit guard, denylist, and tests.
- [ ] Add language guardrail presets for TypeScript, Python, and Go.
- [ ] Add tested Semgrep rules for high-confidence structural policies.
- [ ] Add CI templates and protected-check guidance.
- [ ] Add install, update, drift-check, and backup scripts.

## Principles

- Keep one canonical source whenever behavior is shared.
- Prefer native, dependency-free tooling until a framework earns its cost.
- Keep project-specific versions and configuration in each project.
- Enforce important rules in CI; local hooks are only a fast backstop.
- Never commit credentials, histories, caches, or generated machine state.
