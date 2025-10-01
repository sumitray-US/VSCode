# Security Guide

## Overview
This document describes all security measures and best practices implemented in the user registration system.

## Authentication & Authorization
- Admin endpoints require JWT authentication.
- JWT secrets must be strong and stored securely (never hardcoded).
- JWT expires after 1 hour (configurable).

## Password Handling
- Passwords are hashed using bcryptjs before storage.
- Password complexity enforced (min 8 chars, letters and numbers).

## Environment Variables & Secrets
- All secrets (DB credentials, JWT secret, RabbitMQ URL) are managed via environment variables.
- Use a secrets manager (Azure Key Vault, AWS Secrets Manager) in production.
- Never commit secrets to source control.

## CORS & HTTPS
- CORS restricted to trusted origins via environment variable.
- HTTPS enforced in production (redirects HTTP to HTTPS).

## Rate Limiting & Logging
- Rate limiting middleware protects sensitive endpoints.
- Centralized logging (Winston) for audit and troubleshooting.

## Monitoring & Alerts
- Health checks and metrics endpoints for backend and worker.
- Prometheus/Grafana recommended for monitoring and alerting.

## Secure Deployment
- Use non-root users in Docker containers.
- Keep dependencies up to date to patch vulnerabilities.
- Regularly audit environment and code for security issues.

## Additional Recommendations
- Integrate frontend error reporting (Sentry or similar).
- Review and update secrets regularly.
- Enable automatic security updates for dependencies.

For more details, see [Setup Guide](./SETUPGUIDE.md) and [Monitoring & Scaling](./MONITORING.md).
