# Evidence guide

This guide links to selected screenshots from the project's temporary Kind
integration test and live AWS EKS deployment. The AWS development environment
was destroyed after testing to control costs.

Screenshots show a result at a point in time. They do not, on their own,
prove authorship, full production readiness or every step that led to a
result. Retain the relevant workflow runs and logs where available, and be
prepared to explain the work and any assistance used.

## Kind integration

The application was tested on a temporary Kind cluster in GitHub Actions.

| Evidence | What it shows |
|---|---|
| [Workflow overview](evidence/kind-run-overview.png) | Successful integration workflow |
| [Endpoint tests](evidence/03-kind-endpoint-tests.png) | Application endpoint test results |
| [Kubernetes resources](evidence/04-kind-resources.png) | Resources observed during the integration test |
| [Cluster cleanup](evidence/05-kind-cleanup.png) | Temporary Kind cluster cleanup |

A successful Kind test does not by itself prove that AWS infrastructure was
deployed. See the AWS evidence below for the separate live deployment.

## Live AWS deployment

| Evidence | What it shows |
|---|---|
| [Terraform apply and node checks](evidence/aws/03-terraform-full-apply.png) | Terraform apply output and subsequent Kubernetes checks |
| [Image publishing workflow](evidence/aws/06-image-publish-success.png) | A successful GitHub Actions image-publishing workflow |
| [ALB endpoint checks](evidence/aws/16-platform-api-alb-health-checks.png) | HTTP 200 responses from `/health` and `/ready` |
| [ALB target health](evidence/aws/17-alb-targets-healthy.png) | Two healthy targets visible in the AWS Console |
| [Prometheus query](evidence/aws/25-prometheus-platform-api-targets-up.png) | A query result for application monitoring |
| [Grafana dashboard](evidence/aws/26-grafana-platform-api-dashboard.png) | An application dashboard displaying metrics |
| [Kyverno policy denial](evidence/aws/28-kyverno-policy-enforcement-denied.png) | A noncompliant pod rejected during a server-side dry run |
| [Second Ready node](evidence/aws/31-cluster-autoscaler-second-node-ready.png) | Two Ready nodes observed during the scaling test |
| [HPA scaling](evidence/aws/32-platform-api-hpa-scale-up.png) | HPA output recorded during the scaling test |
| [Four API replicas](evidence/aws/33-platform-api-four-replicas-ready.png) | Four running API pods following scale-up |
| [GitOps self-healing](evidence/aws/35-argocd-automatic-self-healing.png) | Output recorded during the drift-correction test |
| [Configuration rollback](evidence/aws/37-gitops-configuration-rollback.png) | Deployment and pod status recorded after the configuration rollback |
| [Kyverno denial after redeployment](evidence/aws/50-kyverno-policy-denial.png) | A second server-side dry-run denial |
| [Final platform health](evidence/aws/52-final-platform-health.png) | Argo CD Application, node, pod and HPA status before teardown |

The second-node screenshot shows the outcome at that moment. Autoscaler
logs or events are needed to independently establish what triggered the
node scale-up. The rollback test covered configuration; it did not verify
an image-version rollback.

## Interpreting the evidence

- Ready pods and healthy targets show the observed status at the time of
  each check, not a guarantee of continued availability.
- The Kyverno dry run confirms admission rejected that particular test
  manifest; it does not test every possible security case.
- A green validation or scan workflow shows the checks configured for that
  run. It does not guarantee the absence of vulnerabilities.
- The alert test used a synthetic alert received by Alertmanager. External
  email or messaging delivery was not tested.
- The development environment was destroyed after testing. The Terraform
  bootstrap state bucket was retained.

## Handling evidence

Keep exact workflow run URLs and commit SHAs where available. Copy them
from GitHub rather than guessing. Review screenshots before publishing and
remove credentials, tokens, passwords, state contents, payment information
and any personal or account details that should remain private.