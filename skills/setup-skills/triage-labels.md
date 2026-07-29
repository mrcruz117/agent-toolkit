# Triage Labels

The skills speak in terms of six canonical triage roles. This file maps those roles to the actual label strings used in this repo's issue tracker.

| Canonical role    | Label in our tracker | Meaning                                          |
| ----------------- | -------------------- | ------------------------------------------------ |
| `needs-triage`    | `needs-triage`       | Maintainer needs to evaluate this issue          |
| `needs-info`      | `needs-info`         | Waiting on reporter for more information         |
| `ready-for-agent` | `ready-for-agent`    | Fully specified, ready for an AFK agent          |
| `ready-for-human` | `ready-for-human`    | Requires human implementation                    |
| `staged`          | `staged`             | Built and merged to the integration branch       |
| `wontfix`         | `wontfix`            | Will not be actioned                             |

When a skill mentions a role (e.g. "apply the AFK-ready triage label"), use the corresponding label string from this table.

`staged` is applied by `burn-tickets`, not by triage. It means the work is done and sitting on the integration branch awaiting the pull request to the default branch — which is what finally closes the issue. Do not re-triage a `staged` issue.

Edit the right-hand column to match whatever vocabulary you actually use.
