# Production-Style AWS EKS Platform

A hands-on portfolio project combining modular Terraform, AWS EKS, a
containerised Python API, Helm, GitHub Actions, Argo CD, Kubernetes security
policies and observability.

**Status:** The development platform was deployed and tested on AWS EKS.
The environment was destroyed after testing to control costs. This project
has not served production customer traffic.

## What this project demonstrates

- Modular Terraform configuration for AWS networking, EKS, ECR and workload
  identities.
- GitHub Actions image publishing to ECR using AWS OIDC authentication.
- A non-root application container with health, readiness and Prometheus
  metrics endpoints.
- Helm packaging and Argo CD deployment with automated synchronisation.
- Public application access through an AWS Application Load Balancer.
- Prometheus and Grafana monitoring, with alert rules and Alertmanager.
- Kubernetes admission controls using Kyverno.
- Application and node autoscaling tests.
- GitOps drift correction and configuration rollback.
- Deployment and teardown procedures for a temporary AWS environment.

## Verification status

| Capability | Result | Scope or limitation |
|---|---|---|
| Terraform and EKS | Applied the development infrastructure and verified Ready worker nodes | The environment was destroyed after testing |
| ECR publishing | Published the application image through a GitHub Actions workflow using AWS OIDC | The image was deleted during teardown |
| Argo CD | Deployed the application and tested automatic correction of a manual change | The deployment is a portfolio exercise |
| ALB and API | Reached `/health` and `/ready` through the public ALB with HTTP 200 responses | The ALB was removed during teardown |
| Monitoring | Prometheus scraped the API and Grafana displayed application metrics | Monitoring storage was temporary |
| Alerting | Application alert rules were loaded; a synthetic alert fired and was received by Alertmanager | External email or Slack delivery was not tested |
| Kyverno | A noncompliant test pod was denied during server-side dry run | The policy test targeted the `platform` namespace |
| HPA | Application replicas increased from 2 to 4 during a bounded load test | The result is specific to the test environment |
| Cluster Autoscaler | A second worker node became Ready during the scaling test | Exact scale-down timing was not recorded |
| GitOps rollback | Tested a configuration change followed by a Git revert | This was not an image-version rollback |
| AWS cleanup | Removed the development environment and checked the main chargeable resources in the deployment region | The Terraform bootstrap state bucket was retained |

## Architecture

The tested AWS development platform and the separate Kind integration environment are documented in [architecture](docs/architecture.md).

The GitHub Actions publishing workflow tags the image with a Git commit SHA. It does **not** automatically update the Argo CD image reference. A reviewed change must set the ECR repository and published tag before deployment.

## Repository map

| Path | Purpose |
|---|---|
| `.github/workflows/` | Validation, scanning, publishing and Kind integration |
| `apps/platform-api/` | API source, unit tests and Dockerfile |
| `helm/platform-api/` | Application Helm chart and development overrides |
| `argocd/` | GitOps project and application definitions |
| `terraform/bootstrap/` | Remote-state bootstrap configuration |
| `terraform/environments/dev/` | Development infrastructure root module |
| `terraform/modules/` | Reusable AWS infrastructure and identity modules |
| `monitoring/` | Monitoring values, dashboard and alert manifests |
| `policies/` | Kubernetes admission policies |
| `scripts/` | Preflight and integration helpers |
| `docs/` | Architecture, operational guidance and evidence |

## Application endpoints

| Endpoint | Purpose |
|---|---|
| `/` | Application name, status and version |
| `/health` | Liveness response |
| `/ready` | Readiness response |
| `/metrics` | Request count and uptime metrics |

## Reproduce the test without AWS

1. Open the repository's **Actions** tab.
2. Select **Kubernetes integration (no AWS)**.
3. Choose **Run workflow**, select `main` and run it.
4. Review **Deploy and test**, **Diagnostics** and **Delete temporary cluster**.

The manual workflow runs an application integration test on a temporary
Kind cluster. It does not install the complete AWS platform. See the
[integration details](docs/kubernetes-integration.md).

## Redeploy on AWS

Follow the [deployment runbook](docs/deployment-runbook.md) and
[cost and teardown runbook](docs/cost-and-teardown-runbook.md).

The ECR image and VPC from the live test were deleted during cleanup.
A new deployment requires a newly published image and updated
environment-specific Argo CD values. Review the Terraform plan, current
pricing, credentials and configuration before creating resources.

EKS, worker nodes, NAT gateways, ALBs, storage and data transfer may incur
charges. Budget alerts do not cap or stop spending.

## Evidence and operations

- [Evidence and screenshots](docs/evidence-guide.md)
- [Rollback runbook](docs/rollback-runbook.md)
- [Incident response runbook](docs/incident-response-runbook.md)
- [Recovery runbook](docs/recovery-runbook.md)
- [Project explanation and interview practice](docs/project-explanation.md)
- [Remaining work](docs/roadmap.md)
- [Kind integration screenshots](docs/evidence/)

Selected live AWS screenshots are available in the evidence directory.
The evidence guide explains what each screenshot shows and its limitations.

## Limitations

This is a temporary development environment for learning and portfolio
demonstration. It is not a production service. A production implementation
would need further work, including stronger availability, TLS, durable
monitoring and logging, a managed secrets lifecycle and measured recovery
objectives.

## Licence

MIT. See [LICENSE](LICENSE).
