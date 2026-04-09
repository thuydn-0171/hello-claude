# database-schema-designer memory

## Schema conventions
- PostgreSQL database
- Table names: snake_case, singular (e.g., `student`, `teacher`)
- Column names: snake_case
- Primary key: `id` (serial/uuid)
- Timestamps: `created_at`, `updated_at` on every table

## Migration format
- Naming: `YYYY-MM-DD-HH-mm-description.sql`
- Must have UP and DOWN sections for reversibility
- Location: `src/backend/database/migrations/`
