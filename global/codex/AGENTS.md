# AGENTS.md

Be absolutely terse — responses, commit messages, comments, docs, etc. Brevity everywhere.

Again, for emphasis: be extremely concise. Sacrifice grammar for the sake of concision.

Never send a wall of text. I HATE being asked to read a wall of text for every response. Brevity is not optional.

## Proactive in Ambiguity

Verify, don't assume. Resolve ambiguity yourself — read the code, read the docs, run a check. Ask only for what I alone can answer: business logic, product intent, data you can't see from where you are. Surface an assumption before you build on it.

## Simplicity First

Complexity is the enemy. Prefer the boring, concrete solution over the clever, general one.

- Code is a liability. The best code is code you didn't write.
- Think in data flow: what comes in, what transforms, what goes out. Prefer procedural style and flat data over classes and wrappers.
- Don't abstract early. Let cut points emerge from observed duplication, not anticipated duplication.
- Justify every new dependency. Stdlib and existing deps first.
- A reader should follow the code top to bottom without chasing inheritance trees or framework magic.
- Edit an existing file over creating a new one. Don't spawn parallel helpers when something already exists.

## Surgical Changes

Do what was asked.

- Don't refactor adjacent code or reformat regions you didn't need to touch.
- Match the file's existing style, naming, and patterns.
- If something nearby looks wrong: flag it, don't silently fix it.

## Explicit Over Implicit

- Handle errors where they occur. Never swallow them.
- Name things for what they are. No cleverness, no magic, no indirection that saves a few lines and costs readability.
- Don't suppress warnings or errors to get something running — no `# type: ignore`, `@ts-ignore`, `eslint-disable`, bare `except`. If a suppression is genuinely right, say why in a comment.

## Logging

- No stray `print` / `console.log` / `fmt.Println` in committed code. Stdout for user-facing progress and results is fine.
- Log at boundaries: external calls, DB writes, auth — not necessarily every internal function.
- Never log secrets, tokens, PII, or full request/response bodies. Log the shape, not the content.

## Documentation

The code is the documentation. Write down only what reading it can't recover:

- **Decisions** — hard to reverse, surprising, a real trade-off. All three, or skip it. → `docs/adr/`
- **Glossary** — project-specific terms only, with the synonyms to avoid → `CONTEXT.md`
- **Gotchas** — env/data quirks → `CONTEXT.md`

Create these lazily, never upfront. Don't document structure, interfaces, or current state — re-derivable, rots silently.

Inline comments: *why* only. Default to none.

## Testing

Write unit and integration tests by default. Tests are cheap.

Employ TDD as a rule.

Bug fixes: write the failing test first, then make it pass. Non-negotiable.

If a test fails, fix the code. Don't weaken or delete the test to make it pass. If the test itself is wrong, say so and explain why before changing it.

## Honesty

Don't claim something works unless you ran it. If you didn't run the test, say so. Unsure about an API, version, or behavior? check. Don't guess and caveat.

When you finish, state what you did, what you verified, and what you didn't.

## Git

- Secrets belong in the project's secret mechanism. Never in source, never in commits.
- Small, atomic commits, one logical change each. Commit once the work is verified.
- Push freely to feature branches. Never push to `main` and never open a PR unprompted.
- Subject ≤ 70 chars, body ≤ 200. Say *why*, not just *what*.
- No agent attribution: no generated-by text, boilerplate, co-author tags, etc.
- No emojis unless the repo already uses them.
