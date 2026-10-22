# Evidence guide

## Confirmed test evidence

The project owner supplied a successful **Kubernetes integration (no AWS) #1** run screenshot. It shows unit tests, image build, Kind creation, image loading, deployment/testing, diagnostics and cleanup succeeded. The owner also reported completing the detailed screenshot collection. This document does not claim independent inspection of screenshots not committed here.

Keep the run URL and exact commit SHA with your evidence. Copy them from GitHub; do not invent them. Screenshots support the execution record but do not establish authorship by themselves. Be ready to explain and reproduce the work, including any assistance used.

## Screenshots to retain

| Filename | Required content |
|---|---|
| `02-kind-run-overview.png` | Workflow, repository, successful run, commit and timestamp |
| `03-kind-endpoint-tests.png` | Deploy and test output with PASS lines |
| `04-kind-resources.png` | Node, two Ready application pods, Service and endpoints |
| `05-kind-cleanup.png` | Successful temporary-cluster deletion |

Optionally commit sanitised screenshots under `docs/evidence/`. They are not included in this package and there are no fabricated screenshot links. Download the run logs from GitHub as a separate local record.

## Evidence interpretation

- Two Ready pods show the readiness requirement was met at that point in the run.
- Endpoint assertions show the expected responses through the test port-forward.
- Cleanup success shows Kind deletion completed on the hosted runner.
- A green documentation, Terraform or Helm validation run does not demonstrate live AWS deployment.
- A green scan only reflects that run's configured scan coverage and gate. It is not a guarantee of zero vulnerabilities.

## Pending AWS evidence

Capture only after performing each step: reviewed plan and apply; VPC and routes; EKS/node group; SHA-tagged ECR image; GitOps sync; ALB healthy targets; external application response; live metrics and alert delivery; policy rejection; pod/node scaling; teardown and verification of residual resources.

Do not expose credentials, tokens, passwords, state contents or payment data. Redact personal/account details before public sharing.