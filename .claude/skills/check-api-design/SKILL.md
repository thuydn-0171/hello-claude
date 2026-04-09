---
name: check-api-design
description: Check API endpoints against design rules. Use when reviewing new API endpoints or after changes to backend routes.
disable-model-invocation: false
argument-hint: "file-path"
allowed-tools: Read, Glob, Grep
---

Check API design compliance. If $ARGUMENTS is provided, check only that file. Otherwise scan all API files.

1. Read `.claude/rules/api-design.md` to get the current API rules
2. Use Glob to find files matching `src/backend/api/**/*.js` and `src/backend/routes/**/*.js`
   - If $ARGUMENTS is given, check only that file
3. For each file, use Grep to find route definitions (`app.get`, `app.post`, `router.get`, etc.) and check:
   - **Endpoint naming**: uses RESTful conventions, no action verbs in URLs
   - **Response format**: returns `{ success, data, error, timestamp }`
   - **Status codes**: uses semantically correct codes (200, 201, 400, 404, 500)
   - **Auth**: has authentication middleware (except login/signup routes)
4. Report results:
   - `✓ GET /api/resource` — compliant
   - `❌ POST /api/doSomething — action verb in URL` — non-compliant

End with a summary: `N/M endpoints compliant` and list all issues.
