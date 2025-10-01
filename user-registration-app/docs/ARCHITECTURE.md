# Architecture Overview

## System Diagram
```
┌─────────┐   ┌─────────────┐   ┌────────────┐   ┌─────────┐   ┌─────────────┐
│  User   │→│ React Frontend │→│ Express API │→│ RabbitMQ │→│ Worker/SQL DB │
└─────────┘   └─────────────┘   └────────────┘   └─────────┘   └─────────────┘
```

## Data Flow
1. User submits registration via frontend.
2. API validates and enqueues registration in RabbitMQ.
3. Worker processes queue:
	- Validates input
	- Hashes password
	- Checks for duplicates
	- Stores user in SQL DB with status `PENDING`
4. Admin reviews pending users via dashboard, approves/rejects.
5. Status lookup available for users.

## Technology Choices & Rationale
- **Express**: Lightweight, scalable API server, easy to extend.
- **RabbitMQ**: Decouples workflow, enables horizontal scaling and reliability.
- **Azure SQL DB**: Reliable, cloud-native relational storage, supports ACID transactions.
- **React**: Modern, component-based frontend, supports error boundaries and accessibility.
- **Docker Compose**: Simplifies local and cloud deployment, supports scaling.

## Real-World Usage Scenarios
- High registration volume: Scale API and worker containers independently.
- Admins can approve/reject users from anywhere securely.
- Monitoring and alerting for queue depth and service health.

## Scaling & Deployment
- Use Docker Compose for local and cloud deployments.
- Scale backend and worker containers as needed.
- RabbitMQ ensures no lost registrations during spikes.
- Use managed RabbitMQ and SQL DB in production.

## Security
- All secrets via environment variables (never hardcoded).
- JWT authentication for admin endpoints.
- Passwords hashed with bcryptjs.
- CORS restricted to trusted origins.

## Monitoring
- Health checks and Prometheus metrics for all services.
- Grafana dashboards for queue depth, error rates, and service uptime.

## Example Deployment
- Local: `docker-compose up --build`
- Cloud: Deploy containers to Azure/AWS/GCP, use managed RabbitMQ/SQL DB.
