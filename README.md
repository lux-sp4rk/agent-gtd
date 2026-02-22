# Agent GTD (Executive Function Stack)

A complete executive function stack for AI agents. Three layers working together to manage tasks, learning, and state.

| Layer | Tool | Role |
|---|---|---|
| **RAM** | [Taskwarrior](https://taskwarrior.org) | Actionable tasks, current focus, backlog |
| **Hard Drive** | Markdown files | Context, decisions, lore, "why" |
| **Workbench** | `ops/session_state.md` | What I was doing 5 seconds ago |

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
