# api-designer memory

## API conventions
- Base path: `/api/v1/`
- Response format: `{ success, data, error, timestamp }`
- Auth: JWT Bearer token in Authorization header
- Rate limiting: 100 req/min per IP for public endpoints

## Design decisions
- Pagination uses `page/limit/total` format, not cursor-based
- Error codes are UPPER_SNAKE_CASE (e.g., `VALIDATION_ERROR`)
- All endpoints require auth except `/auth/login` and `/auth/register`
