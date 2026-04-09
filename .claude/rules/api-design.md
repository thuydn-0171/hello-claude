---
paths:
  - "src/backend/api/**/*.js"
  - "src/backend/api/**/*.ts"
  - "src/backend/routes/**/*.js"
---

# API Design Rules

Referenced by: `.claude/agents/api-designer`, `/check-api-design` skill

## Endpoint Naming

- Use RESTful conventions
- Pattern: `POST /resource`, `GET /resource/:id`, `PUT /resource/:id`
- Avoid actions in URLs, use HTTP methods instead

## Response Format

All API responses must follow this format:

```json
{
  "success": true,
  "data": { /* actual payload */ },
  "error": null,
  "timestamp": "2026-04-06T10:30:00Z"
}
```

## Error Handling

- HTTP status codes must be semantically correct
  - 200: Success
  - 201: Created
  - 400: Bad request (client error)
  - 404: Not found
  - 500: Server error

Example error response:

```json
{
  "success": false,
  "data": null,
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Invalid email format",
    "details": { "field": "email" }
  },
  "timestamp": "2026-04-06T10:30:00Z"
}
```

## Authentication

- All endpoints require authentication (except login/signup)
- Use JWT tokens in Authorization header: `Authorization: Bearer <token>`
- Include user context in request: `req.user`

## Rate Limiting

- Implement rate limiting for public endpoints
- Default: 100 requests per minute per IP
- Adjustable per endpoint based on sensitivity

## Documentation

- API endpoints must be documented in `src/backend/api/RULES.md`
- Use OpenAPI/Swagger format for specifications
- Include example requests and responses

---

**Validation:** Run `/check-api-design` to validate API endpoints
