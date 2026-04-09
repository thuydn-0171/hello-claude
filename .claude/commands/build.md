---
name: build
description: "Build for production"
---

# Build Command

Build optimized production bundle.

## What it does
- Runs `npm run build`
- Creates optimized bundle
- Generates `/build` directory
- Production-ready code

## When to use
- Before deploying to production
- Testing production build locally
- Checking bundle size
- Performance profiling

## Example
```
/build
→ Building...
→ Creates: /build directory
→ Ready for deployment
```

## Output
- `/build/` - Optimized bundle
- `index.html` - Main entry point
- `static/` - JS/CSS assets
- `favicon.ico` - Icon

## Tips
- First build takes 1-2 minutes (cached)
- Serve locally: `npx serve -s build`
- Check bundle size regularly
- Minified and optimized
