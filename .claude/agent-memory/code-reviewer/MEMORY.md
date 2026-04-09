# code-reviewer memory

## Project patterns
- React 18 with functional components only, no class components
- Backend uses Node.js with Express
- Naming: camelCase for variables/functions, PascalCase for components
- Tests co-located with source: `Component.test.js` next to `Component.js`

## Recurring issues
- Missing input validation in API handlers (`src/backend/api/`)
- Inline functions in render methods causing unnecessary re-renders
- Inconsistent error handling patterns across backend services
