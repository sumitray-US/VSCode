# Project Documentation Index

This folder contains all key documentation for the user registration system. Use this index to discover and navigate:

- [Setup Guide](./SETUPGUIDE.md): How to install, configure, and deploy the system.
- [API Reference](./APIREFERENCE.md): Full specification of all backend API endpoints, requests, responses, and error codes.
- [Architecture Overview](./ARCHITECTURE.md): System design, data flow, technology choices, scaling, and deployment.
- [Backend Workflow & API](./WORKFLOW.md): Registration and approval workflow, state transitions, admin/user guides, error handling.
- [Monitoring & Scaling](./MONITORING.md): Health checks, metrics, Prometheus/Grafana setup, alerting, troubleshooting.
- [Queue Monitoring](./QUEUEMONITORING.md): RabbitMQ queue health, alerting, dashboard setup, and troubleshooting.
- [Security Guide](./SECURITY.md): Authentication, password handling, secrets management, CORS/HTTPS, rate limiting, secure deployment.
- [Frontend Guide](./FRONTEND.md): UI structure, component hierarchy, accessibility, error boundaries, API integration, troubleshooting.
- [Test Strategy](./TESTING.md): Coverage goals, test file locations, CI integration, sample cases, troubleshooting, best practices.
- [Contributing Guide](./CONTRIBUTING.md): Branching, PR workflow, code style, testing, documentation, troubleshooting for contributors.

## Quickstart
See [Setup Guide](./SETUP_GUIDE.md) for installation, environment setup, and running instructions.

## FAQ
- **How do I reset my admin password?**
	- Use `create-admin.js` in backend to create a new admin user.
- **How do I scale the system?**
	- See [Monitoring & Scaling](./MONITORING.md) and [Queue Monitoring](./QUEUE_MONITORING.md).
- **Where are the API endpoints?**
	- See [API Reference](./API_REFERENCE.md).
- **How do I secure my deployment?**
	- See [Security Guide](./SECURITY.md).

## Troubleshooting
- If registration fails, check backend logs and RabbitMQ status.
- For database errors, verify Azure SQL connection and credentials.
- For frontend issues, run tests and check browser console for errors.
- For queue issues, see [Queue Monitoring](./QUEUE_MONITORING.md).

For further help, contact the project maintainer.
