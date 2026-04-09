# Frontend Rules

Guidelines for React components and UI development.

## Component Structure

- **Use functional components** with React Hooks (useState, useEffect, useContext)
- **One component per file** - name files PascalCase matching component name
- **Keep components focused** - break into smaller components if doing multiple things
- **Props over context** for simple data passing, use context only for deeply nested trees

## File Organization

```
src/frontend/
├── components/        # Reusable UI components
├── pages/            # Page-level components (if routing)
├── hooks/            # Custom React hooks
├── utils/            # Helper functions and utilities
├── styles/           # Shared CSS/styling
└── RULES.md
```

## Naming Conventions

- Component files: `PascalCase` (e.g., `UserCard.js`)
- Hook files: `use*` prefix (e.g., `useAuth.js`)
- Utility files: `camelCase` (e.g., `formatDate.js`)
- CSS classes: `kebab-case` (e.g., `.card-header`)

## Props & State

- Use descriptive prop names
- Define PropTypes or TypeScript types for all props
- Initialize state with meaningful default values
- Keep state as local as possible, lift only when necessary

## Performance

- Memoize expensive components with `React.memo()`
- Use `useCallback` for event handlers passed to child components
- Lazy load routes and heavy components with `React.lazy()`

## Styling

- Use CSS modules or inline styles, avoid global styles
- Keep component styles colocated with components
- Use consistent spacing, colors, typography
