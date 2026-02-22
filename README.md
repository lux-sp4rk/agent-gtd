# Agent GTD (Executive Function Stack)

A complete executive function stack for AI agents. This is not about a human managing an AI's tasks—it's about an **autonomous agent self-managing its own cognitive overhead** using GTD (Getting Things Done) principles.

| Layer | Tool | Role |
|---|---|---|
| **RAM** | [Taskwarrior](https://taskwarrior.org) | Actionable tasks, internal focus, backlog |
| **Hard Drive** | Markdown files | Context, decisions, lore, "why" |
| **Workbench** | `ops/session_state.md` | Real-time state recovery (where I was 5 seconds ago) |

## The Value Prop: From Chatbot to Operator

Most agents rely on static "self-improvement" prompts that are forgotten as soon as the session resets. **Agent GTD** deprecates these loops by giving the agent a persistent **Internal Prefrontal Cortex**:

- **Self-Correcting:** When a command fails, the agent logs an `+error`.
- **Persistent Learning:** When corrected by a user, it logs a `+learning` to be promoted to its core identity.
- **Async Execution:** It manages its own `+next` actions across session resets.
- **Witness Gates:** High-stakes actions (destructive or public) are gated behind explicit approval.

By giving an agent its own Taskwarrior database, you shift from "prompting for better behavior" to "building a data-driven improvement pipeline."

## Overview

This skill implements a high-performance executive function stack designed for autonomous agents. It moves beyond simple "prompts" into structured state management using standard Linux CLI tools.

### 1. The Inbox (Capture)
Everything goes into the inbox first. No processing at capture time.
```bash
task add +in "description"
```

### 2. Error & Learning Capture
Log failures immediately. Don't wait for review time.
```bash
task add project:Internal.Learnings +error "command / tool failed"
```

### 3. Session Continuity
The **Workbench** protocol for `ops/session_state.md` ensures that if a session resets, the agent can recover its previous context instantly.

## Installation

This is an [OpenClaw](https://openclaw.ai) skill.

```bash
clawhub install agent-gtd
```

## References

- `references/taskwarrior-schema.md` — Installation, `.taskrc` config, UDAs, custom reports.
- `references/review-runbook.md` — Periodic review loop (2 min → 20 min depth levels).
- `references/vitality-heartbeat.md` — Agent silence detection and alerting.

---
*Created by [Lux Sp4rk](https://luxsp4rk.beehiiv.com/)*
