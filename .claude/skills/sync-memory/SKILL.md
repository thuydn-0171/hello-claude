---
name: sync-memory
description: Sync and validate agent memory files. Checks MEMORY.md indexes and ensures all linked files exist.
disable-model-invocation: true
user-invocable: false
argument-hint: "project|agents"
allowed-tools: Read, Glob, Grep
---

Sync and validate memory files. If $ARGUMENTS is `project`, check only project memory. If `agents`, check only agent memory. Otherwise check both.

**Project memory** (skip if $ARGUMENTS is `agents`):
1. Read `~/.claude/projects/*/memory/MEMORY.md` if it exists
2. Parse all file links in the format `[title](file.md)`
3. For each linked file, verify it exists
4. Report broken links

**Agent memory** (skip if $ARGUMENTS is `project`):
1. Use Glob to find `.claude/agent-memory/*/MEMORY.md`
2. For each agent's MEMORY.md, Read it and:
   - Parse all file links
   - Verify each linked file exists
   - Check that entries have proper format (name, description, type in frontmatter)
3. Report any broken links or malformed entries

**Report format:**
```
Project Memory:
✓ MEMORY.md — N files linked, all valid

Agent Memory:
✓ code-reviewer/MEMORY.md — valid
❌ api-designer/MEMORY.md — broken link: designs.md not found
```

End with: `All synced ✓` or list issues that need fixing.
