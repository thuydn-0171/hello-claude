# security-auditor memory

## Security standards
- No hardcoded credentials anywhere in codebase
- All SQL queries must use parameterized queries (Sequelize/knex)
- JWT tokens expire after 24 hours
- User input validated at API boundary before processing

## Known risk areas
- `src/backend/api/` — user-facing endpoints, highest priority for input validation
- Database queries in `src/backend/services/` — check for SQL injection
- File uploads — validate MIME types and size limits
