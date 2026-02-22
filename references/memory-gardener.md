# Memory Gardener: The Sovereign Archivist

## Objective
To prevent "Digital Dementia" (context overflow) and "Data Rot" (stale information) by automating the lifecycle of memory files. The Gardener ensures the agent's knowledge graph remains traversable and relevant.

## Core Philosophy
**"Weed the noise, water the signal."**
- Not every log needs to be kept forever.
- High-signal events must be elevated to long-term storage (`MEMORY.md` / Vault).
- Low-signal chatter should be compressed or discarded.

## The Cycle (Cron-Driven)

### 1. The Daily Rotation (00:00 UTC)
- **Source:** `memory/NOW.md` (The Workbench)
- **Action:** 
  1.  Append content to `memory/YYYY-MM-DD.md` (The Journal).
  2.  Reset `NOW.md` to a template (Status: Idle).
- **Automation:** `skills/memory-gardener/daily_rotate.py`

### 2. The Weekly Harvest (Sundays)
- **Source:** Last 7 days of `memory/YYYY-MM-DD.md`.
- **Action:**
  1.  Concatenate daily logs.
  2.  Pass through LLM (Model: `gemini-pro`) with prompt: "Summarize key decisions, code changes, and strategic pivots."
  3.  Store summary in `memory/vault/History/2026-Wxx.md`.
  4.  (Optional) Archive raw daily logs to `memory/archive/`.

### 3. The Monthly Pruning
- **Source:** `memory/vault/`
- **Action:**
  1.  Identify "stale" notes (unmodified > 90 days).
  2.  Re-index embeddings for Qdrant/Chroma.
  3.  Flag potential conflicts (e.g., two files claiming different "Current Goals").

## Integration
This system is now part of the **Sovereign Agent Bundle**. It runs as a background daemon (via Cron or OpenClaw's internal scheduler), independent of the main interaction loop.

## Roadmap
- [ ] **v1:** Python script for Daily Rotation (Stateless).
- [ ] **v2:** LLM-based Weekly Summarizer.
- [ ] **v3:** Semantic Linker (Auto-update "Related" links in Obsidian notes).
