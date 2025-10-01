# Setup Guide

## Prerequisites
- Node.js 18+
- Docker & Docker Compose
- Azure SQL Database
- RabbitMQ (Docker Compose included)

## Example Environment Variables
```
DB_USER=admin
DB_PASSWORD=yourStrongPassword
DB_SERVER=your-sql-server.database.windows.net
DB_NAME=registrationdb
JWT_SECRET=yourSuperSecretKey
RABBITMQ_URL=amqp://rabbitmq
CORS_ORIGINS=http://localhost,http://yourdomain.com
```

## Steps
1. Clone the repository:
	```bash
	git clone https://github.com/your-org/user-registration-app.git
	cd user-registration-app
	```
2. Copy `.env.example` to `.env` in both root and backend, and fill in secrets.
3. Install dependencies:
	```bash
	npm install
	cd backend && npm install
	```
4. Start services:
	```bash
	docker-compose up --build
	```
5. Access frontend at `http://localhost`, admin dashboard at `/admin`, status lookup at `/status`.
6. Run tests:
	```bash
	npm test
	cd backend && npm test
	```

## User Guide
- Register via the main page.
- Check status via `/status` page.

## Admin Guide
- Login via `/admin` page.
- Approve/reject users in dashboard.

## Deployment
- For production, use a secrets manager for environment variables.
- Deploy containers to cloud (Azure, AWS, GCP) using managed services.
- Set up monitoring and alerting as described in `/docs/MONITORING.md`.

## Troubleshooting
- Registration errors: Check backend logs and RabbitMQ status.
- Database errors: Verify Azure SQL connection and credentials.
- Frontend errors: Run tests and check browser console.
- Common issues:
  - Ports already in use: Stop other services or change port in `.env`.
  - Database connection refused: Check firewall and credentials.
  - RabbitMQ not starting: Check Docker logs and restart container.

## Notes
- For production, set strong secrets and use a secrets manager.
- See `/docs/SECURITY.md` for security best practices.
