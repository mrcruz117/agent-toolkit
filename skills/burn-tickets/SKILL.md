---
name: burn-tickets
description: Work a queue of ready tickets one at a time — a fresh subagent per ticket via /implement, verified and merged to the integration branch by the orchestrator, labelled staged.
disable-model-invocation: true
---

# Burn Tickets

Work the ticket queue sequentially. **You are the orchestrator. You do not write code.**

One subagent per ticket, each with a fresh context. You stay lean so the loop can run long.

## Before starting

Invoking this skill authorises the whole loop — spawning subagents, running verifiers, merging to the integration branch, labelling. Do not stop to ask permission for any of it. If something is missing, halt and name it; never interview the user mid-loop.

1. Read `docs/agents/issue-tracker.md` for how to list, label, and read tickets. Missing: halt, tell the user to run `/setup-skills`.
2. Find the command that runs the full test suite — what CI runs, if there is CI. Say which one you picked. If you can't find one, or it doesn't run clean on the integration branch before you start, halt: an unverified loop merges unverified work.
3. Integration branch is `dev` unless the user named another. Missing: halt.
4. Ticket cap is 10 unless the user named another.
5. If the user named a spec, candidates are only that spec's tickets. Otherwise the whole queue.

## The loop

Repeat until no candidates remain, the cap is hit, or a ticket fails.

1. **Pick.** Candidates are tickets labelled `ready-for-agent` whose every "Blocked by" entry is closed or `staged`. Take the lowest-numbered candidate — FIFO. No candidates means stop, and say why.

2. **Delegate.** Spawn one subagent on a branch off the integration branch. Its whole instruction is to run `/implement` on that one ticket and commit. Tell it to return only: ticket id, branch name, done or failed, and brief reason. Nothing else.

3. **Verify yourself.** Run the full test suite on the ticket's branch, plus any command the ticket names. Exit codes decide. The subagent's report is a claim, not evidence — it does not count. A failed check is feedback, not an immediate halt: send the exact command and output back to the same subagent for correction, then rerun verification. Formatting, lint, and generated-file failures are routine repair work.

4. **Merge.** On green, merge the branch into the integration branch. On red after the repair policy below, stop the loop.

5. **Label.** Apply `staged` to the ticket when merged to the integration branch. Do not close it.

6. **Report one line** to the user, then continue.

## Rules

- **Never let a subagent merge.** It has every incentive to declare victory and no view of the other tickets.
- **Never read a subagent's full transcript.** Take the status line. Reading them is how the orchestrator's context fills and the loop degrades.
- **Repair before halting.** Give the same subagent up to two corrective passes using the exact failure output. Halt if the same failure persists, the fix escapes ticket scope, or the subagent is blocked. Leave the branch intact and never skip ahead.
- **Do not close tickets.** Closure is a side effect of merging the integration branch to the default branch. `Closes #N` in a ticket commit never fires from `dev`, so leave it out.
- **One ticket at a time.** Parallel agents conflict far more often than sequential ones.

## When the queue drains

Report what was staged. Offer to open the integration branch's pull request against the default branch, with a `Closes #N` line per staged ticket so merging it closes them all at once.
