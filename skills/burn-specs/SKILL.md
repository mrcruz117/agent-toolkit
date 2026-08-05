---
name: burn-specs
description: Drain the spec queue — run burn-tickets on one spec at a time until the queue empties or a spec halts.
disable-model-invocation: true
---

Take the lowest-numbered `spec` issue whose tickets aren't all `staged`. Run the `/burn-tickets` skill on it.

When it drains green, move to the next spec. When it halts, stop — do not move on.

At the end, report in a few lines: specs drained, specs left, where it stopped and why.
