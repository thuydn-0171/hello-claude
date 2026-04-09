#!/bin/bash
# .claude/hooks/task-submit.sh
#
# UserPromptSubmit hook - fires when user submits a prompt
# Receives JSON input from stdin with "prompt" field
# Returns additionalContext to guide Claude toward relevant agents

INPUT=$(cat)
PROMPT=$(echo "$INPUT" | jq -r '.prompt // ""' | tr '[:upper:]' '[:lower:]')

AGENTS=()

# Match keywords to specialized agents
if echo "$PROMPT" | grep -qiE 'code review|review code|naming|quality|lint|refactor'; then
  AGENTS+=("code-reviewer")
fi
if echo "$PROMPT" | grep -qiE '\bapi\b|endpoint|rest|route|http method'; then
  AGENTS+=("api-designer")
fi
if echo "$PROMPT" | grep -qiE 'database|schema|migration|sql|table|column'; then
  AGENTS+=("database-schema-designer")
fi
if echo "$PROMPT" | grep -qiE 'security|vulnerability|auth|injection|xss|csrf|secret|token|password'; then
  AGENTS+=("security-auditor")
fi
if echo "$PROMPT" | grep -qiE 'performance|optimize|slow|speed|cache|memory|profil'; then
  AGENTS+=("performance-optimizer")
fi

# Only emit additionalContext when agents are matched
if [ ${#AGENTS[@]} -gt 0 ]; then
  AGENT_LIST=$(IFS=', '; echo "${AGENTS[*]}")
  jq -n --arg agents "$AGENT_LIST" '{
    hookSpecificOutput: {
      hookEventName: "UserPromptSubmit",
      additionalContext: ("Suggested specialized agents for this task: " + $agents + ". Use these agents when appropriate.")
    }
  }'
fi

exit 0
