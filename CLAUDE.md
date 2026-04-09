# Project Guide

## Tech Stack

- React 18.2.0 with react-scripts 5.0.1
- Node.js backend with Express
- PostgreSQL database

## Commands

- Dev: `npm start`
- Build: `npm run build`
- Test: `npm test`
- Lint: `npm run lint`

## Project Structure

```
src/
├── frontend/          # React components, hooks, utils
└── backend/
    ├── api/           # REST API endpoints
    ├── database/
    │   └── migrations/
    └── services/
```

Each layer has its own `RULES.md` loaded on demand when Claude reads files in that directory.

## Coding Standards

- Use 2-space indentation
- Variables and functions: `camelCase`
- React components: `PascalCase`
- Constants: `UPPER_SNAKE_CASE`
- File naming: `ComponentName.js`, `useHookName.js`, `ComponentName.test.js`
- Tests co-located with source: `Button.test.js` next to `Button.js`
- Functions under 50 lines, single responsibility
- No hardcoded secrets — use environment variables
- Comments explain "why", not "what"
- No unused variables or imports

## API Standards

- RESTful endpoints: `GET /api/v1/resource`, `POST /api/v1/resource`
- All responses: `{ success: bool, data: object|null, error: object|null, timestamp: string }`
- Auth: JWT Bearer token in `Authorization` header
- All endpoints require auth except `/auth/login` and `/auth/register`
- Rate limiting: 100 req/min per IP
- Error codes: `UPPER_SNAKE_CASE` (e.g., `VALIDATION_ERROR`)
- Pagination: `{ page, limit, total }` format

## Database Standards

- Table names: `snake_case`, singular (e.g., `student`, not `students`)
- Column names: `snake_case`
- Every table has `id`, `created_at`, `updated_at`
- All SQL queries use parameterized queries (never string concatenation)
- Migration naming: `YYYY-MM-DD-HH-mm-description.sql`
- Migrations must have UP and DOWN sections

## Git Workflow

- Run `npm test` before committing
- Commit messages: imperative mood ("Add feature", not "Added feature")
- Pre-commit hook validates RULES.md files, agent configs, and migrations
- Post-commit hook updates agent memory (async)

## Rules System

- `.claude/rules/coding-standards.md` — always loaded
- `.claude/rules/testing.md` — loaded when working with `*.test.js`, `*.spec.js`
- `.claude/rules/api-design.md` — loaded when working with `src/backend/api/**`
- `src/*/CLAUDE.md` — layer-specific, loaded on demand per directory

## Common Gotchas

- Don't mock the database in integration tests — use test fixtures
- Don't use `lodash` full import — import specific functions: `import debounce from 'lodash/debounce'`
- React components must use `React.memo()` for expensive renders
- Always validate user input at the API boundary before processing

<!-- Architecture docs: .claude/docs/architecture.md -->
<!-- Run /check-rules to see which rules apply to your current files -->
