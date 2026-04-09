---
name: validate-migrations
description: Validate database migration files for correct naming, structure, and SQL. Use before committing database changes.
disable-model-invocation: true
argument-hint: "migration-file"
allowed-tools: Read, Glob, Grep
---

Validate database migration files. If $ARGUMENTS is provided, validate only that file. Otherwise validate all migrations.

1. Use Glob to find files matching `src/backend/database/migrations/*.sql`
   - If $ARGUMENTS is given, filter to only that file
2. For each migration file, Read it and check:
   - **Naming**: follows `YYYY-MM-DD-HH-mm-description.sql` format
   - **UP section**: contains `-- UP` or `-- migrate:up` marker
   - **DOWN section**: contains `-- DOWN` or `-- migrate:down` marker (reversible)
   - **Table names**: use `snake_case` (no camelCase or PascalCase)
   - **Column names**: use `snake_case`
   - **Dangerous ops**: if `DROP TABLE` or `DROP COLUMN` is found, verify there's a warning comment
3. Report results:
   - `✓ filename.sql` — valid
   - `❌ filename.sql — reason` — invalid

End with a summary: `N/M migrations valid` and list all issues.
