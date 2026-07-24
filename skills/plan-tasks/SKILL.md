---
name: "plan-tasks"
description: "Turn an agreed plan into a loop-grade implementation spec with discrete checkboxes and real verifier commands. Use when the user asks to plan tasks, make a loop-grade plan, prepare goal-mode work, convert brainstorming into executable steps, or run the planning stage before /goal."
---

# plan-tasks

Turn the current plan into a spec that goal mode or a loop can close.

## First, Reconcile

Do not start from scratch unless there is no relevant plan. Check the current conversation, visible plan-mode state, and any project docs that track active work.

- Relevant plan with open boxes: build on it.
- Relevant plan already complete, obsolete, or absent: start fresh.
- Mostly exploratory work with no measurable done state: say so and recommend prose planning instead.

## Rules

1. Use discrete markdown checkboxes: - [ ].
2. Bind each non-human checkbox to a real verifier command from this repo. Inspect manifests, Makefiles, task runners, and test files before naming commands.
3. Do not invent verifier commands. If no verifier exists and the work has a stable interface, add a test/eval task first.
4. Mark subjective or external checks as HUMAN GATE and keep them out of the machine stop condition.
5. Put human checks under Human sign-off.
6. End with Stop condition containing only machine-observable commands whose exit codes can be shown in the session.
7. Produce or revise the plan only. Do not start executing.

## Output Shape

Use this shape:

## Tasks
- [ ] <task> - verified by <command>

## Human sign-off
- [ ] HUMAN GATE: <what the user must confirm>

## Stop condition
<command>
