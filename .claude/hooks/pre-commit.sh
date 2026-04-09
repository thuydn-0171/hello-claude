#!/bin/bash
# .claude/hooks/pre-commit.sh
#
# PreToolUse hook - fires before Bash tool runs "git commit"
# Receives JSON input from stdin
# Exit 0  = allow, exit 2 = block with error message to Claude

INPUT=$(cat)
COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command // ""')

# Only validate git commit commands
if ! echo "$COMMAND" | grep -qE 'git commit'; then
  exit 0
fi

ERRORS=()
PROJECT="$CLAUDE_PROJECT_DIR"

# 1. Check required RULES.md files exist
RULES_FILES=(
  "src/frontend/RULES.md"
  "src/backend/RULES.md"
  "src/backend/api/RULES.md"
  "src/backend/database/RULES.md"
)
for f in "${RULES_FILES[@]}"; do
  if [ ! -f "$PROJECT/$f" ]; then
    ERRORS+=("Missing required file: $f")
  fi
done

# 2. Check agent config files exist
AGENT_FILES=(
  ".claude/agents/code-reviewer.md"
  ".claude/agents/api-designer.md"
  ".claude/agents/database-schema-designer.md"
  ".claude/agents/security-auditor.md"
  ".claude/agents/performance-optimizer.md"
)
for f in "${AGENT_FILES[@]}"; do
  if [ ! -f "$PROJECT/$f" ]; then
    ERRORS+=("Missing agent config: $f")
  fi
done

# 3. Validate migration filename convention: NNN_description.sql
MIGRATION_DIR="$PROJECT/src/backend/database/migrations"
if [ -d "$MIGRATION_DIR" ]; then
  for f in "$MIGRATION_DIR"/*.sql; do
    [ -f "$f" ] || continue
    fname=$(basename "$f")
    if ! echo "$fname" | grep -qE '^[0-9]{3}_[a-z0-9_]+\.sql$'; then
      ERRORS+=("Invalid migration filename: $fname (expected: NNN_description.sql)")
    fi
  done
fi

if [ ${#ERRORS[@]} -gt 0 ]; then
  echo "Pre-commit validation failed:" >&2
  for err in "${ERRORS[@]}"; do
    echo "  - $err" >&2
  done
  exit 2
fi

exit 0
