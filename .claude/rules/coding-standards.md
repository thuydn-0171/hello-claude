# Coding Standards

Referenced by: `code-reviewer` agent, all RULES.md files

## Naming Conventions

### JavaScript/React

- **Variables & functions:** camelCase
  ```js
  const userName = "John";
  const getUserData = () => {...};
  ```

- **React Components:** PascalCase
  ```jsx
  const UserCard = () => {...};
  export const UserProfile = () => {...};
  ```

- **Constants:** UPPER_SNAKE_CASE
  ```js
  const MAX_RETRY_COUNT = 3;
  const API_BASE_URL = "https://api.example.com";
  ```

- **File names:**
  - Components: `ComponentName.js`
  - Hooks: `useHookName.js`
  - Utils: `utilityName.js`
  - Tests: `ComponentName.test.js`

## Code Quality

- Maximum line length: 100 characters
- Use meaningful variable names (no abbreviations like `u`, `x`, `tmp`)
- Functions should do one thing (Single Responsibility)
- Keep functions under 50 lines when possible
- No unused variables or imports

## Comments

- Only use comments to explain "why", not "what"
- Bad: `// increment count` (obvious from code)
- Good: `// retry logic requires exponential backoff to avoid overwhelming service`

## Security

- No hardcoded credentials or secrets
- Use environment variables for sensitive data
- Validate all user input
- Sanitize SQL queries / use parameterized queries
- See also: `src/backend/api/RULES.md`

## Performance

- Use React.memo() for expensive components
- Use useCallback() for callback dependencies
- Avoid inline function definitions in renders
- Profile before optimizing
- See also: Performance Optimizer agent

---

**Validation:** Run `/validate-rules` to check coding standards compliance
