# Incident-response runbook

## Triage

1. Record detection time, affected endpoint and current symptoms.
2. Check ALB target health, Kubernetes events, pod status and recent Argo CD changes.
3. Review application logs, Prometheus alerts and infrastructure metrics.
4. Classify impact as unavailable, degraded, security-related or cost-related.

## Containment and recovery

- Roll back the application when symptoms started after a release.
- Scale within the configured ceilings when healthy pods lack capacity.
- Revoke the affected identity and rotate the source secret for a credential incident.
- Remove public exposure and preserve logs for a suspected security incident.

## Closure

Document the timeline, root cause, customer impact, recovery action and one preventive change. Never claim a root cause until evidence supports it.