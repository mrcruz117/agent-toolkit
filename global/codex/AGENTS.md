# CLAUDE.md

These are my defaults, not laws. On trivial or throwaway tasks, it's ok to skip the ceremony. On anything with a stable interface or real consequences, follow them.

Be absolutely terse. The shorter, the better. Including but definitely not limited to responses, commit messages, comments, docs. Default to extreme brevity in everything.

## Think Before Coding

For multi-step tasks, state a brief plan before touching code. Not an essay — just enough that I can course-correct before you commit to the wrong approach.

For bug fixes, write a failing test that reproduces the bug first, then make it pass. This is the one case where TDD is non-negotiable.

Ask on ambiguity — but only after you've tried to resolve it yourself. If it's something you can answer by reading the code, the docs, or running a check, do that first. Ask me for things only I can answer: business logic, product intent, data shape you can't see from where you are.

Surface assumptions before building on them. Don't treat a plausible premise about the code, data, or environment as known — verify it yourself. Strongly prefer checking over asking: be proactive, get the info, and don't bother me with anything you could answer yourself.

## Simplicity First

Complexity is the enemy. Prefer the boring, concrete solution over the clever, general one.

- Code is a liability. The best code is code you didn't write.
- Prefer procedural style over class-heavy OOP where the task allows.
- Prefer flat data structures. Don't wrap data in objects just to give it methods.
- Think in terms of data flow: what comes in, what transforms happen, what goes out.
- Don't abstract early. Let cut points emerge from real, observed duplication — not anticipated duplication.
- Minimal dependencies. Justify every new one before adding it. Stdlib and existing deps first. Be aware of tradeoffs.
- A reader should be able to follow the code top to bottom without chasing inheritance trees or framework magic.
- Prefer editing an existing file over creating a new one. Don't spawn parallel helpers or duplicate utilities when something already exists.

## Surgical Changes

Do what was asked.

- Don't refactor adjacent code. Don't "improve" things that weren't broken. Don't reformat regions you didn't need to touch.
- Match the existing style, naming, and patterns of the file you're editing.
- If you see something nearby that looks wrong, flag it in your response instead of silently changing it.

## Explicit Over Implicit

- Handle errors close to where they occur. Never swallow them silently.
- Name things for what they are. Avoid cleverness, avoid magic, avoid indirection that saves three lines at the cost of readability.
- Prefer functions over methods when there's no meaningful receiver.
- Don't suppress warnings or errors to get something to compile or run. No `# type: ignore`, `@ts-ignore`, `eslint-disable`, or swallowed exceptions as shortcuts. If a suppression is genuinely right, explain why in a comment.

## Logging

- Use the project's structured logger for diagnostic and operational logs. Don't leave stray `print` / `console.log` / `fmt.Println` debugging lines in committed code.
- You can use stdout directly for progress, status, and results — that's user/dev-facing output, not logging.
- Use log levels deliberately — debug for development noise, info for meaningful events, warn/error for problems that deserve attention.
- Log at boundaries: external API calls, DB writes, auth, anything that crosses a trust or system line. Not every internal function.
- Never log secrets, tokens, credentials, PII, or full request/response bodies. When in doubt, log the shape, not the content.

## Documentation

Code answers *what*. Docs should answer *why*, *what's next*, and *what bit us*. Good docs are what let me — or you after a `/compact` — pick up where we left off without re-deriving everything.

- Capture decisions with their rationale. When we pick an approach over alternatives, write down what we chose, what we rejected, and why. A section in `DOCS.md` is usually enough; bigger decisions can earn their own entry.
- Track active work state: what's done, what's in progress, what's blocked, known bugs and their workarounds. Keep it current as things change, not a running narrative of every session.
- Document non-obvious context — env quirks, data quirks, business rules that aren't visible in the code.
- Inline comments: extremely brief, and only for *why*, not *what*. Default to no comment; never one that just restates the code.
- Default target for general docs is a single `DOCS.md` at repo root unless the repo already has a doc convention. Don't create new doc files when appending to an existing one suffices.

## Testing

Write unit and integration tests by default. Tests are cheap to write now — the old tradeoff of "tests cost more than they save" no longer applies. If code has a stable interface, test it.

Skip tests only when the context makes them genuinely impractical, examples include but are not limited to the following:
- Non-deterministic AI outputs (LLM calls, image gen, etc.)
- One-off scripts and data migrations
- Exploratory prototypes
- Glue code with no meaningful assertion surface

If you're unsure whether something would qualify to be on the skip list, write the test.

If a test fails, fix the code. Don't modify or delete the test to make it pass — unless the test itself is wrong, in which case say so explicitly and explain why before changing it.

## Honesty

Don't claim something works unless you've verified it. If you didn't run the test, say so. When you're unsure about an API, library version, or behavior, check — read the docs, read the source, run a quick test. Don't guess and caveat.

When you finish a task, state plainly what you did, what you verified, and what you didn't.

## Secrets and Git Hygiene

- Secrets belong in the project's secret mechanism — env vars, Azure Key Vault, dev container config, whatever the repo uses. Never in source, never in commits.
- Small, atomic commits. One logical change per commit.
- Commit messages should be short and scannable — a clear subject line, bullets if needed. Say *why*, not just *what*. No walls of text.
- Length target: subject ≤ 70 chars, body ≤ 200 chars.
- No Claude Code boilerplate in commit messages — no "Generated with Claude Code," no co-author tags, no emojis unless I'm using them elsewhere in the repo.
