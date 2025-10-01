# Queue Monitoring Recommendations

## Monitoring
- Monitor RabbitMQ queue length and worker health.
- Use Prometheus and Grafana for metrics and dashboards.

## Alerting Examples
- Alert if queue depth exceeds threshold for sustained period.
- Alert on worker process crash or restart.

## Troubleshooting
- If queue is stuck, check worker logs and RabbitMQ status.
- Restart worker if necessary.
- Review error logs for root cause.
