# Production-Style AWS EKS Platform

A portfolio platform combining modular Terraform, a containerised Python API, Helm, GitHub Actions, Argo CD, security controls and observability configuration.

**Status:** repository validation completed during development and application integration passed on a temporary Kind cluster in GitHub Actions. Live AWS EKS deployment is pending. This project has not served production customer traffic.

## What this project demonstrates

- Reusable infrastructure modules for VPC, ECR, EKS, workload identity and budget alerts.
- A non-root application container with health, readiness and Prometheus metrics endpoints.
- A Helm chart with resource requests/limits, probes and optional platform integrations.
- CI checks for infrastructure, application, Helm, GitOps, monitoring, policies and runbooks.
- A manual runtime test that builds the image, loads it into Kind, deploys two replicas, checks endpoints and removes the cluster.
- Prepared GitOps configuration for monitoring, policy enforcement, ingress and scaling.
- Operational deployment, rollback, recovery and teardown procedures.

## Verification status

| Capability | Current evidence | Still to verify |
|---|---|---|
| Application | Unit tests and Kind integration passed | Behaviour under realistic load |
| Helm deployment | Two replicas and endpoint assertions passed in Kind | EKS scheduling and networking |
| Terraform | CI validation passed during development | Reviewed AWS plan and successful apply |
| ECR publishing | Manual OIDC workflow and IAM configuration exist | Live authentication and image push |
| Argo CD | Manifests validated | Live sync, reconciliation and rollback |
| ALB | Controller identity and Ingress configured | AWS provisioning and healthy targets |
| Monitoring | Stack, dashboard and alert configuration validated | Live scraping, dashboard and alert delivery |
| Kyverno | Policies and validation exist | Live admission rejection |
| HPA / node scaling | Configuration exists | Live metrics, scale-up and scale-down |
| Budgets | Alert configuration exists | AWS budget creation and notification delivery |

Validation is not proof that infrastructure has been provisioned or that every runtime integration works. See [evidence guide](docs/evidence-guide.md).

## Architecture

The AWS target design and the tested Kind environment are documented separately in [architecture](docs/architecture.md).

The ECR workflow publishes an image with a Git commit SHA tag. It does **not** automatically update Argo CD's configured image tag. A reviewed Git change must set the real ECR repository and published SHA before Argo CD can deploy that image.

## Repository map

| Path | Purpose |
|---|---|
| `.github/workflows/` | Validation, scanning, publishing and Kind integration |
| `apps/platform-api/` | API source, unit tests and Dockerfile |
| `helm/platform-api/` | Application Helm chart and development overrides |
| `argocd/` | GitOps application definitions |
| `terraform/bootstrap/` | Remote-state bootstrap configuration |
| `terraform/environments/dev/` | Development infrastructure root module |
| `terraform/modules/` | Reusable AWS infrastructure and identity modules |
| `monitoring/` | Monitoring values, dashboard and alert manifests |
| `policies/` | Kubernetes admission policies |
| `scripts/` | Preflight and integration helpers |
| `docs/` | Architecture, operational guidance and evidence |

## Reproduce the test without AWS

1. Open the repository's Actions tab.
2. Select **Kubernetes integration (no AWS)**.
3. Choose **Run workflow**, select `main`, and run it.
4. Review **Deploy and test**, **Diagnostics** and **Delete temporary cluster**.

The workflow only runs manually and skips private repositories. It uses a standard hosted Ubuntu runner, no AWS credentials, no cache and no uploaded artifacts. Consult your account's billing settings before changing visibility or runner type.

The test disables Ingress, autoscaling, ServiceMonitor, NetworkPolicy and topology spread through test-only overrides. It does not install the complete platform. See [integration details](docs/kubernetes-integration.md).

## Application endpoints

| Endpoint | Purpose |
|---|---|
| `/` | Application name, status and version |
| `/health` | Liveness response |
| `/ready` | Readiness response |
| `/metrics` | Request count and uptime metrics |

## Live AWS deployment

Live deployment remains a separate stage. Follow the [deployment runbook](docs/deployment-runbook.md) and [cost and teardown runbook](docs/cost-and-teardown-runbook.md). Review the Terraform plan, current service pricing, account eligibility, credentials and placeholders before creating resources.

EKS, worker nodes, NAT gateways, ALBs, storage and data transfer may incur charges. Budget alerts do not cap or stop spending. Do not run the publishing workflow before the AWS identity and ECR repository exist.

## Operations and portfolio

- [Rollback](docs/rollback-runbook.md)
- [Incident response](docs/incident-response-runbook.md)
- [Recovery](docs/recovery-runbook.md)
- [Evidence and screenshots](docs/evidence-guide.md)
- [Project explanation and interview practice](docs/project-explanation.md)
- [Remaining work](docs/roadmap.md)

## Kubernetes integration evidence

The application passed integration testing on a temporary Kind
cluster in GitHub Actions. Live AWS EKS deployment remains pending.

- [Successful workflow run](docs/evidence/kind-run-overview.png)
- [Endpoint test results](docs/evidence/03-kind-endpoint-tests.png)
- [Kubernetes resources](docs/evidence/04-kind-resources.png)
- [Cluster cleanup](docs/evidence/05-kind-cleanup.png)

[View all screenshots](docs/evidence/)

## Licence

MIT. See [LICENSE](LICENSE).
