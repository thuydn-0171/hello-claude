#!/bin/bash
# .claude/hooks/post-commit.sh
#
# PostToolUse hook - fires after Bash tool successfully runs "git commit"
# Receives JSON input from stdin (includes tool_input + tool_response)
# Runs async - cannot block. Used for logging and memory updates.

INPUT=$(cat)
COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command // ""')

# Only process git commit completions
if ! echo "$COMMAND" | grep -qE 'git commit'; then
  exit 0
fi

TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
MEMORY_FILE="$CLAUDE_PROJECT_DIR/.claude/agent-memory/MEMORY.md"

# Append commit event to agent memory index
if [ -f "$MEMORY_FILE" ]; then
  cat >> "$MEMORY_FILE" <<EOF

<!-- commit-log: $TIMESTAMP -->
<!-- command: $COMMAND -->
EOF
fi

exit 0
