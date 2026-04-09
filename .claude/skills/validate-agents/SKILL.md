---
name: validate-agents
description: Validate all agent files in .claude/agents/ for correct frontmatter and configuration. Use when adding or editing agents.
disable-model-invocation: false
allowed-tools: Read, Glob
---

Validate all agent configuration files. Follow these steps:

1. Use Glob to find all files matching `.claude/agents/*.md`
2. For each agent file, Read it and check the YAML frontmatter:
   - `name` field exists and is lowercase with hyphens only
   - `description` field exists and is not empty
   - `tools` field exists and only contains valid tools: `Read, Write, Edit, Bash, Grep, Glob, Agent`
   - `model` field (if present) is one of: `haiku`, `sonnet`, `opus`, `claude-haiku-4-5`, `claude-sonnet-4-6`, `claude-opus-4-6`
3. Check for duplicate `name` values across all agents
4. Report results:
   - `✓ agent-name.md` — valid
   - `❌ agent-name.md — reason` — invalid

End with a summary: `N/M agents valid` and list all issues found.
