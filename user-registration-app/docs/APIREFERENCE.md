# API Reference

## Registration
- `POST /register`
  - Request:
    ```json
    { "username": "user1", "email": "user1@example.com", "password": "yourpassword" }
    ```
  - Response:
    ```json
    { "status": "PENDING", "userId": 123 }
    ```
  ## Registration
  - **Endpoint:** `POST /register`
  - **Description:** Registers a new user. Places user in PENDING state.
  - **Request Body:**
    - `username` (string, required, 3-32 chars, alphanumeric)
    - `email` (string, required, valid email format)
    - `password` (string, required, min 8 chars, must contain letters and numbers)
  - **Validation:**
    - Username must be unique
    - Email must be unique
    - Password must meet complexity requirements
  - **Response:**
    - Success: `{ "status": "PENDING", "userId": 123 }`
    - Error: `{ "error": "Duplicate username" }`, `{ "error": "Invalid email" }`, etc.
  - **Edge Cases:**
    - Duplicate registration
    - Invalid email format
    - Weak password
  - **Example:**
    ```bash
    curl -X POST http://localhost:4000/register -H "Content-Type: application/json" -d '{"username":"user1","email":"user1@example.com","password":"Password123"}'
    ```

## Admin Login
  ## Admin Login
  - **Endpoint:** `POST /admin/login`
  - **Description:** Authenticates admin and returns JWT.
  - **Request Body:**
    - `username` (string, required)
    - `password` (string, required)
  - **Response:**
    - Success: `{ "token": "<JWT>" }`
    - Error: `{ "error": "Invalid credentials" }`
  - **Authentication:** JWT required for all admin endpoints.
  - **Example:**
    ```bash
    curl -X POST http://localhost:4000/admin/login -H "Content-Type: application/json" -d '{"username":"admin","password":"adminpassword"}'
    ```
  - Request:
    ```json
  ## Pending Users
  - **Endpoint:** `GET /users/pending`
  - **Description:** Returns all users in PENDING state. Requires admin JWT.
  - **Headers:** `Authorization: Bearer <JWT>`
  - **Response:**
    - Success: `[ { "id": 123, "username": "user1", "email": "user1@example.com", "status": "PENDING", "created_at": "2025-09-28T12:00:00Z" } ]`
    - Error: `{ "error": "Unauthorized" }`
  - **Example:**
    ```bash
    curl -H "Authorization: Bearer <JWT>" http://localhost:4000/users/pending
    ```
    ```
  - Response:
  ## Approve User
  - **Endpoint:** `POST /users/approve/:id`
  - **Description:** Approves a pending user. Requires admin JWT.
  - **Headers:** `Authorization: Bearer <JWT>`
  - **Response:**
    - Success: `{ "status": "APPROVED" }`
    - Error: `{ "error": "User not found" }`, `{ "error": "Unauthorized" }`
  - **Example:**
    ```bash
    curl -X POST http://localhost:4000/users/approve/123 -H "Authorization: Bearer <JWT>"
    ```
    { "token": "<JWT>" }
    ```
  ## Reject User
  - **Endpoint:** `POST /users/reject/:id`
  - **Description:** Rejects a pending user. Requires admin JWT.
  - **Headers:** `Authorization: Bearer <JWT>`
  - **Response:**
    - Success: `{ "status": "REJECTED" }`
    - Error: `{ "error": "User not found" }`, `{ "error": "Unauthorized" }`
  - **Example:**
    ```bash
    curl -X POST http://localhost:4000/users/reject/123 -H "Authorization: Bearer <JWT>"
    ```
    - `401 Unauthorized`: Invalid credentials

  ## Status Lookup
  - **Endpoint:** `GET /status/:username`
  - **Description:** Returns registration status for a user.
  - **Response:**
    - Success: `{ "status": "PENDING" }`
    - Error: `{ "error": "User not found" }`
  - **Example:**
    ```bash
    curl http://localhost:4000/status/user1
    ```
- `GET /users/pending` (admin JWT required)
  - Request header:
  ## Health & Metrics
  - **Endpoint:** `GET /health`
  - **Description:** Returns health status of backend.
  - **Response:** `{ "status": "ok" }`
  - **Endpoint:** `GET /metrics`
  - **Description:** Returns Prometheus metrics for monitoring.
  - **Response:** Prometheus format
  - Response:
    ```json
  ## Authentication
  - All admin endpoints require JWT in `Authorization: Bearer <JWT>` header.
  - Obtain JWT via `/admin/login`.
  - JWT expires after 1 hour (configurable).
  - Use strong secrets for JWT signing.
    ```
  - Errors:
  - `400 Bad Request`: Invalid input
  - `401 Unauthorized`: Missing/invalid JWT
  - `404 Not Found`: Resource not found
  - `409 Conflict`: Duplicate registration
    - `401 Unauthorized`: Missing/invalid JWT

  - See [Setup Guide](./SETUP_GUIDE.md) for environment setup.
  - See [Test Strategy](./TESTING.md) for API test cases.
## Approve User
- `POST /users/approve/:id` (admin JWT required)
  - Request header:
    `Authorization: Bearer <JWT>`
  - Response:
    ```json
    { "status": "APPROVED" }
    ```
  - Errors:
    - `404 Not Found`: User not found
    - `401 Unauthorized`: Missing/invalid JWT

## Reject User
- `POST /users/reject/:id` (admin JWT required)
  - Request header:
    `Authorization: Bearer <JWT>`
  - Response:
    ```json
    { "status": "REJECTED" }
    ```
  - Errors:
    - `404 Not Found`: User not found
    - `401 Unauthorized`: Missing/invalid JWT

## Status Lookup
- `GET /status/:username`
  - Response:
    ```json
    { "status": "PENDING" }
    ```
  - Errors:
    - `404 Not Found`: User not found

## Health & Metrics
- `GET /health` — returns `{ "status": "ok" }`
- `GET /metrics` — Prometheus metrics

## Authentication
- Admin endpoints require JWT in `Authorization: Bearer <JWT>` header.
- Obtain JWT via `/admin/login`.

## Example curl commands
```bash
# Register user
curl -X POST http://localhost:4000/register -H "Content-Type: application/json" -d '{"username":"user1","email":"user1@example.com","password":"yourpassword"}'

# Admin login
curl -X POST http://localhost:4000/admin/login -H "Content-Type: application/json" -d '{"username":"admin","password":"adminpassword"}'

# Approve user
curl -X POST http://localhost:4000/users/approve/123 -H "Authorization: Bearer <JWT>"

# Status lookup
curl http://localhost:4000/status/user1
```
