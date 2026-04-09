# Architecture & Workflows

## How Rules Connect

```
.claude/rules/                    ← UNIVERSAL (what ALL code should follow)
    ↓
    ├─ Agents read these when analyzing code
    ├─ Skills validate these standards
    └─ Hooks check these before commit

src/*/CLAUDE.md                    ← SPECIFIC (how each layer implements rules)
    ↓
    ├─ Loaded on demand when Claude reads files in that directory
    └─ Combines with .claude/rules/ for complete validation
```

## Development Workflow

1. `/dev` — start development server
2. Make changes (watched by dev server)
3. Validate:
   - `/check-rules` — show relevant rules
   - `/validate-rules` — check RULES.md compliance
   - `/validate-migrations` — check DB migrations (if modified)
4. Review with agents:
   - `code-reviewer` — code quality
   - `api-designer` — API endpoints (if API changes)
   - `security-auditor` — security review (if needed)
5. `git commit` — triggers pre-commit hook (validation) + post-commit hook (memory)
6. `/build` — build for production

## Hook System

### PreToolUse: pre-commit.sh
Runs before `git commit`:
- Checks RULES.md files
- Verifies agent configurations
- Validates database migrations
- Blocks commit if validation fails (exit code 1)

### PostToolUse: post-commit.sh
Runs after `git commit` (async):
- Records commit info for memory
- Triggers agent analysis
- Cannot fail the commit (already created)

### UserPromptSubmit: task-submit.sh
Runs when you submit a prompt:
- Analyzes task keywords
- Suggests relevant agents (code review → code-reviewer, api → api-designer, etc.)

## Agent Memory System

Each agent with `memory: project` stores findings in `.claude/agent-memory/<name>/MEMORY.md`.
Agents with `memory: local` store in `.claude/agent-memory-local/<name>/MEMORY.md` (not committed).

Memory is auto-managed: first 200 lines of MEMORY.md loaded into agent's system prompt at startup.

## Example: Code Review Flow

1. Run code-reviewer agent on modified code
2. Agent reads `.claude/rules/coding-standards.md` + `src/frontend/RULES.md`
3. Agent finds issues, analyzes patterns
4. Agent updates `.claude/agent-memory/code-reviewer/MEMORY.md`
5. Next review leverages learned patterns

## Example: API Design Flow

1. Run api-designer agent for new endpoint
2. Agent reads `.claude/rules/api-design.md` + `src/backend/api/RULES.md`
3. Agent designs endpoint, validates response format
4. Agent updates `.claude/agent-memory/api-designer/MEMORY.md`

## Quick Reference

| Task | Command/Agent |
|------|---------------|
| Review code | code-reviewer agent |
| Design API | api-designer agent |
| Plan schema | database-schema-designer agent |
| Security audit | security-auditor agent |
| Optimize perf | performance-optimizer agent |
| Validate rules | `/validate-rules` |
| Build | `/build` |
