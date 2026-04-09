---
name: validate-rules
description: Validate all RULES.md files for proper structure and content. Use when checking if rule files are valid before committing.
disable-model-invocation: true
allowed-tools: Read, Glob, Grep
---

Validate all RULES.md files in this project. Follow these steps:

1. Use Glob to find all files matching `**/RULES.md`
2. For each file found, Read it and check:
   - Has at least one markdown heading (`#`)
   - Has non-empty content (more than 5 lines)
   - Does not have broken references to files that don't exist
3. Also check that expected rule files exist:
   - `src/frontend/RULES.md`
   - `src/backend/RULES.md`
   - `src/backend/api/RULES.md`
   - `src/backend/database/RULES.md`
4. Report results in this format:
   - `✓ path/to/RULES.md` — valid
   - `❌ path/to/RULES.md — reason` — invalid or missing

End with a summary: `N/M files valid` and list any issues found.
