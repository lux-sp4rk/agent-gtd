#!/usr/bin/env bash
# task-comment.sh — Append a durable comment to a task-scoped markdown thread
# Usage: task-comment.sh <task-id> "comment text"
#        task-comment.sh <task-id> --stdin        (read from stdin)
#
# Writes to: memory/tasks/<task-uuid>.md
# Format:   ## YYYY-MM-DD HH:MM — <agent_name>
#           <comment text>

set -euo pipefail

TASK_ID="${1:-}"
COMMENT="${2:-}"
AGENT_NAME="${AGENT_NAME:-${OPENCLAW_AGENT_NAME:-unknown}}"
MEMORY_DIR="${MEMORY_DIR:-${HOME}/.openclaw/agents/${AGENT_NAME}/workspace/memory}"
TASKS_DIR="${MEMORY_DIR}/tasks"

# ── Validation ─────────────────────────────────────────────────────────────
if [[ -z "$TASK_ID" ]]; then
    echo "Usage: task-comment.sh <task-id> \"comment text\"" >&2
    echo "       task-comment.sh <task-id> --stdin" >&2
    exit 1
fi

# Read from stdin if requested
if [[ "$COMMENT" == "--stdin" ]]; then
    COMMENT=$(cat)
fi

if [[ -z "$COMMENT" ]]; then
    echo "Error: comment text is empty" >&2
    exit 1
fi

# ── Resolve task UUID ──────────────────────────────────────────────────────
TASK_JSON=$(task "${TASK_ID}" export 2>/dev/null || true)
if [[ -z "$TASK_JSON" ]]; then
    echo "Error: task ${TASK_ID} not found" >&2
    exit 1
fi

TASK_UUID=$(echo "$TASK_JSON" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d[0]['uuid'] if isinstance(d,list) else d['uuid'])" 2>/dev/null || true)
TASK_DESC=$(echo "$TASK_JSON" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d[0]['description'] if isinstance(d,list) else d['description'])" 2>/dev/null || true)

if [[ -z "$TASK_UUID" ]]; then
    echo "Error: could not extract UUID for task ${TASK_ID}" >&2
    exit 1
fi

# ── Write comment ──────────────────────────────────────────────────────────
mkdir -p "$TASKS_DIR"
TASK_FILE="${TASKS_DIR}/${TASK_UUID}.md"

TIMESTAMP=$(date '+%Y-%m-%d %H:%M')

# Create file header if it doesn't exist
if [[ ! -f "$TASK_FILE" ]]; then
    cat > "$TASK_FILE" <<EOF
# Task ${TASK_ID}: ${TASK_DESC}

EOF
fi

# Append comment block
cat >> "$TASK_FILE" <<EOF
## ${TIMESTAMP} — ${AGENT_NAME}
${COMMENT}

EOF

echo "✓ Comment added to task ${TASK_ID} (${TASK_UUID})"
echo "  File: ${TASK_FILE}"
