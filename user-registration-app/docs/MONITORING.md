# Monitoring & Scaling Guidance

## Health Checks

## Scaling
  - `docker-compose up --scale backend=3 --scale worker=3`

## Monitoring

## Example Prometheus Queries

## Alerting Setup

## Dashboard Example

## Recommendations

## Advanced Prometheus Queries
- `up{job="backend"}`: Check backend health.
- `rabbitmq_queue_messages_ready{queue="registration"}`: Pending registrations.
- `sum(rate(http_requests_total[5m])) by (status)`: HTTP request rate by status code.
- `avg(process_cpu_seconds_total)`: Average CPU usage.

## Alerting Setup
- Set alerts for high queue depth, service downtime, or error rates.
- Example: Alert if `rabbitmq_queue_messages_ready > 100` for 5 minutes.
- Alert if backend health check fails for 2 consecutive intervals.

## Dashboard Setup
- Use Grafana to visualize health, queue depth, error rates, and resource usage.
- Example panels: Service uptime, queue depth, error rate, CPU/memory usage.

## Troubleshooting
- Backend/worker not responding: Check container logs and health endpoints.
- Queue stuck: Check RabbitMQ management UI and worker logs.
- Metrics missing: Verify Prometheus scrape configs and endpoints.
