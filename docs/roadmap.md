# Remaining work

## Completed portfolio milestone

The platform was deployed and tested on a temporary AWS EKS development
environment. The practical work covered:

- Terraform infrastructure provisioning and EKS worker readiness.
- GitHub Actions image publishing to ECR using AWS OIDC.
- Argo CD deployment and application access through an AWS ALB.
- Prometheus scraping, a Grafana dashboard and a synthetic alert received
  by Alertmanager.
- Kyverno admission enforcement using a noncompliant test pod.
- HPA replica scaling and a worker-node scaling test.
- GitOps self-healing and a configuration rollback.
- Teardown of the development environment and checks for common remaining
  chargeable resources in the deployment region.

The application was also integration-tested on a temporary Kind cluster
in GitHub Actions.

## Portfolio completion

- Review and sanitise live AWS screenshots before adding selected evidence
  to the repository.
- Add relevant workflow run links where available.
- Review the deployment and teardown runbooks against the live experience.
- Keep project claims aligned with the evidence and practise explaining
  the architecture, tests, troubleshooting and limitations.
- Review the Terraform provider lock files and local Git changes before
  committing.

## Follow-up work

- Investigate the monitoring alerts deferred during the live session.
- Review the Kyverno policy API deprecation and plan a migration.
- Review the Kyverno CRD comparison adjustment when upgrading Kyverno or
  Argo CD.
- Consider how ECR images should be retained or deleted during teardown.
- Test external alert delivery if email or messaging integration is added.
- Test an image-version rollback and record recovery timings.
- Recheck current component compatibility and AWS pricing before redeployment.

## Production considerations

This is a portfolio development environment, not a production service.
A production design would need further work, including:

- Higher availability and resilience across failure scenarios.
- TLS for public application traffic.
- Durable monitoring and logging.
- A managed secrets lifecycle.
- Defined and measured recovery objectives.
- Reviewed security, access controls, cost controls and operating procedures.