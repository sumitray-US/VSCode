# Backend Workflow & API Documentation

## Workflow Diagram
```
┌─────────┐   ┌─────────────┐   ┌────────────┐   ┌─────────┐   ┌─────────────┐
│  User   │→│ React Frontend │→│ Express API │→│ RabbitMQ │→│ Worker/SQL DB │
└─────────┘   └─────────────┘   └────────────┘   └─────────┘   └─────────────┘
```

## Workflow Steps
1. User submits registration via frontend.
2. API validates and enqueues registration in RabbitMQ.
3. Worker processes registration:
	- Validates input
	- Hashes password
	- Checks for duplicates
	- Stores user in SQL DB with status `PENDING`
4. Admin logs in and reviews pending users.
5. Admin approves or rejects user:
	- Status changes to `APPROVED` or `REJECTED`
6. User can check status via status lookup.

## State Transitions
- `PENDING` → `APPROVED` (admin approval)
- `PENDING` → `REJECTED` (admin rejection)
- `PENDING` → `PENDING` (no action)

## Admin Guide
- Login via `/admin` page using credentials.
- View pending users in dashboard.
- Approve or reject users with one click.
- All actions require valid JWT.

## User Guide
- Register via main page.
- Check status via `/status` page.
- If rejected, re-register with new credentials.

## Error Handling
- API returns clear error codes and messages (see API Reference).
- All errors logged centrally (Winston logger).
- Frontend displays error messages with accessibility support.

## Extending the Backend
- Add new endpoints in `api/routes.js`.
- Extend workflow logic in `workflow/handlers.js`.
- Add new states or transitions as needed.
