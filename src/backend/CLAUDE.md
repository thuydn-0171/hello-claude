# Backend Rules

General guidelines for backend development.

## Code Organization

```
src/backend/
├── api/               # REST API routes and handlers
├── database/          # Database models and migrations
├── services/          # Business logic
├── middleware/        # Custom middleware
├── utils/             # Helper functions
└── RULES.md
```

- Group related functionality into modules/services
- Separate concerns: routes, controllers, services, repositories
- Keep business logic in services, not in route handlers
- Use dependency injection for testability

## Error Handling

- Use consistent error response format: `{ error: "message", code: "ERROR_CODE" }`
- Log errors with context (user ID, request ID, timestamp)
- Return appropriate HTTP status codes
- Never expose internal errors to clients - sanitize error messages

## Security

- Validate all inputs (type, length, format)
- Sanitize data before storing/returning
- Use parameterized queries to prevent SQL injection
- Implement authentication & authorization checks
- Use HTTPS in production, validate SSL certificates
- Store sensitive data encrypted

## Testing

- Write unit tests for services and utilities
- Write integration tests for API endpoints
- Aim for >80% code coverage on critical paths
- Mock external dependencies in unit tests
- Use separate test database for integration tests

## Naming Conventions

- Functions: camelCase (e.g., `getUserById()`)
- Constants: UPPER_SNAKE_CASE (e.g., `MAX_RETRIES`)
- Classes: PascalCase (e.g., `UserService`)

## Logging

- Log important operations (auth, data changes, errors)
- Include request/correlation ID for tracing
- Use appropriate log levels (INFO, WARN, ERROR, DEBUG)
- Avoid logging sensitive data (passwords, tokens, PII)
