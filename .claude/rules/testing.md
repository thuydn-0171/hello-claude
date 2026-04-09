---
paths:
  - "**/*.test.js"
  - "**/*.spec.js"
  - "src/backend/database/migrations/**"
---

# Testing Rules

Referenced by: `.claude/agents/`, `/validate-agents` skill, code-reviewer agent

## Unit Tests

- All functions must have corresponding test cases
- Minimum coverage: 80% for critical paths
- Use Jest for React components
- Use Jest or Mocha for backend logic

## Integration Tests

- Test API endpoints with real database
- Don't mock the database - use test fixtures instead
- Verify workflow paths, not just individual functions

## Test Structure

```
src/
├── frontend/
│   ├── components/
│   │   └── Component.test.js      # Jest snapshot + behavior
│   └── hooks/
│       └── useHook.test.js
└── backend/
    ├── api/
    │   └── endpoint.test.js       # Integration tests
    └── services/
        └── service.test.js        # Unit tests
```

## Test Naming

- Test file: `ComponentName.test.js` (co-locate with source)
- Test suite: `describe('ComponentName', () => {...})`
- Test case: `it('should [action] when [condition]', () => {...})`

## Database Migrations

- All DB changes must have corresponding migration files
- Migration naming: `YYYY-MM-DD-HH-mm-description.sql`
- See: `src/backend/database/RULES.md` for migration specifics

---

**Validation:** Run `/validate-migrations` before committing database changes
