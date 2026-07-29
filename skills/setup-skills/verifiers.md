# Verifiers

The commands that decide whether work is good. Skills read this file instead of guessing.

Fill only the roles this repo actually has. An omitted role is fine; a wrong one is not.

```md
# Verifiers

**Full:** `make check`
The gate. What CI runs. If this is green the work is acceptable.

**Unit:** `go test ./...`

**Integration:** `go test -tags=integration ./...`
Slow — ~4 min. Needs docker compose up.

**Typecheck:** `npx tsc --noEmit`

**Lint:** `ruff check .`

## Notes

- Anything flaky, and how flaky. A verifier that fails at random makes an unattended loop meaningless.
- Anything that needs setup before it will run (services, fixtures, env vars).
```

## Rules

- **Full is the gate.** It should be the same command CI runs, not a superset someone hopes is equivalent. If CI runs a workflow rather than one command, name the workflow and the command it invokes.
- **Real commands only.** Every one must have been run in this repo and observed to pass. Do not transcribe a script name from `package.json` without running it.
- **No invented roles.** If there are no integration tests, omit the line.
