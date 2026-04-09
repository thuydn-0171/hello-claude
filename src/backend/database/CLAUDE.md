# Database Rules

Guidelines for database design and queries.

## Schema Design

- Use surrogate keys (auto-increment id) as primary keys
- Name tables in snake_case, singular form: `user`, `product`, `order`
- Use appropriate column types: INT for numbers, VARCHAR/TEXT for strings, TIMESTAMP for dates
- Add indexes on frequently queried columns (WHERE, JOIN, ORDER BY)
- Use foreign keys to maintain referential integrity
- Add constraints: NOT NULL, UNIQUE, CHECK where applicable

## Naming Conventions

- Table names: `snake_case` (e.g., `user_profiles`)
- Column names: `snake_case` (e.g., `created_at`, `user_id`)
- Index names: `idx_{table}_{column}` (e.g., `idx_users_email`)
- Foreign key names: `fk_{table}_{column}` (e.g., `fk_orders_user_id`)

## Migrations

- Every schema change must have a migration
- Migrations must be reversible (up and down)
- Name migrations with timestamp: `001_create_users_table.sql`
- Test migrations on dev and staging before production
- Keep migrations focused on single changes

## Query Performance

- Use SELECT specific columns, not SELECT *
- Always filter with WHERE clause for large tables
- Use LIMIT when appropriate
- Index foreign keys and frequently searched columns
- Avoid SELECT N+1 problems - use JOIN instead
- Use EXPLAIN to analyze slow queries

## Data Integrity

- Use transactions for multi-step operations
- Set appropriate isolation levels for concurrent access
- Validate data before insertion/update
- Use database constraints over application validation
- Regular backups and test restore procedures

## Security

- Never concatenate user input into queries - use parameterized queries
- Encrypt sensitive columns: passwords, API keys, PII
- Apply row-level access control in queries
- Audit sensitive operations (deletes, updates)
- Use database user with minimal required permissions

## Scaling

- Archive old data instead of deleting
- Partition large tables by date/range
- Consider read replicas for heavy read loads
- Monitor query performance and indexes
- Set connection pool limits appropriate to load

## Example Schema

```sql
CREATE TABLE users (
  id INT PRIMARY KEY AUTO_INCREMENT,
  email VARCHAR(255) NOT NULL UNIQUE,
  password_hash VARCHAR(255) NOT NULL,
  first_name VARCHAR(100),
  last_name VARCHAR(100),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_users_email (email)
);

CREATE TABLE orders (
  id INT PRIMARY KEY AUTO_INCREMENT,
  user_id INT NOT NULL,
  total_amount DECIMAL(10, 2),
  status VARCHAR(50),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY fk_orders_user_id (user_id) REFERENCES users(id)
);
```
