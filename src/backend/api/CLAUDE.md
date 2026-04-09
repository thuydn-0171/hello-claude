# API Rules

Specific guidelines for REST API endpoints.

## Route Definitions

- Group related routes by resource (users, products, orders, etc.)
- Use nested routes for relationships: `/users/{id}/orders`
- Include API version in base path: `/api/v1/`
- Keep routes clean and predictable

## Request Handling

- Validate request body schema before processing
- Check required headers (Content-Type, Authorization)
- Set reasonable request size limits (1MB default)
- Timeout long-running requests (30s default)

## Response Format

All successful responses should follow this structure:
```json
{
  "data": { /* response payload */ },
  "status": "success",
  "timestamp": "2026-04-06T10:30:00Z"
}
```

Error responses:
```json
{
  "error": "Human-readable error message",
  "code": "ERROR_CODE",
  "status": "error",
  "timestamp": "2026-04-06T10:30:00Z"
}
```

## HTTP Status Codes

- `200 OK` - Successful GET, PUT, PATCH
- `201 Created` - Successful POST
- `204 No Content` - Successful DELETE
- `400 Bad Request` - Invalid input
- `401 Unauthorized` - Missing/invalid authentication
- `403 Forbidden` - Authenticated but no permission
- `404 Not Found` - Resource not found
- `409 Conflict` - Duplicate or conflicting data
- `422 Unprocessable Entity` - Validation error
- `500 Internal Server Error` - Server error

## Pagination

For list endpoints:
```json
{
  "data": [ /* items */ ],
  "pagination": {
    "page": 1,
    "limit": 20,
    "total": 150,
    "pages": 8
  }
}
```

## Rate Limiting

- Implement rate limiting per IP/user
- Return `429 Too Many Requests` when exceeded
- Include rate limit headers in response:
  - `X-RateLimit-Limit`
  - `X-RateLimit-Remaining`
  - `X-RateLimit-Reset`

## Documentation

- Document endpoint purpose, parameters, and responses
- Include example requests and responses
- Document authentication requirements
- Document possible error responses
