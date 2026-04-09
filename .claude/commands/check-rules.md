---
name: check-rules
description: "Show relevant rules for current context"
---

# Check Rules Command

Display applicable RULES.md files based on current work context.

## What it does
- Analyzes which file you're editing
- Loads relevant rule files
- Shows applicable guidelines
- Displays best practices

## When to use
- Before starting work on a file
- When unsure about conventions
- When need security requirements
- Designing API endpoints
- Creating database migrations

## Examples

### Frontend Component
```
Editing: src/frontend/components/Button.js

/check-rules
→ Shows: Global rules + Frontend rules
→ Displays: Component naming, hooks, performance, styling
```

### Backend API
```
Editing: src/backend/api/users.js

/check-rules
→ Shows: Global rules + Backend rules + API rules
→ Displays: Routes, validation, errors, status codes
```

### Database Migration
```
Editing: src/backend/database/migrations/001_*.sql

/check-rules
→ Shows: Global rules + Backend rules + Database rules
→ Displays: Schema design, naming, indexes, constraints
```

## Tips
- Run at start of task to understand expectations
- Reference output while coding
- Understand "why" behind rules
- Follow naming conventions shown
- Check security requirements
