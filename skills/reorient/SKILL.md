---
name: "reorient"
description: "Rebuild file-grounded repository context before new work. Use when the user asks to reorient, get bearings, refresh context, continue after compaction, recover after context loss, inspect what is going on, or start an explore stage before planning."
disable-model-invocation: true
---

# reorient

Rebuild a file-grounded mental model of the current repository before planning or editing.

## Inputs

Treat any arguments as focal paths or topics to deep-dive after the base orientation.

## Procedure

1. Treat compact summaries, prior conclusions, and memory as unverified until checked against files.
2. Read guidance in order when present: AGENTS.md, then CLAUDE.md, then README.md. Follow clearly relevant docs they reference.
3. Inspect git state: git status, git branch --show-current, git log --stat -5, git log --name-only -15, and git diff HEAD~5..HEAD --stat when the branch has at least 5 commits.
4. Inspect project shape with rg --files when available; otherwise use the platform directory listing. Exclude dependency, build, cache, and VCS folders.
5. Read manifests that exist: package.json, pyproject.toml, requirements.txt, go.mod, Cargo.toml, root Dockerfile, docker-compose.yml, Makefile, and infra config.
6. Read entry points surfaced by guidance, README, manifests, routing, or app config.
7. Deep-dive focal areas: use provided focal paths when supplied; otherwise infer from dirty files and recent churn. Open every dirty file from git status. Trace at least one concrete code path through each focal area.
8. Before summarizing, confirm you opened guidance files, README, dirty files, and top recent files in focal areas. If not, keep reading.

## Output

Emit a concise, file-grounded summary:

- Project: what it does, stack
- Key directories: one line each
- Entry points: main files, APIs, CLI commands, or routes
- Active focus: current work inferred from git state/logs and conversation
- Open threads: dirty files, visible half-finished changes, parked docs
- Gaps: specific unknowns that remain

End with: Ready to continue - what's next?
