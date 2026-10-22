# Temporary Kubernetes integration test

Upload the .github, scripts and docs folders to the repository root. These are new files; do not replace existing AWS files or Helm values.

Commit message: ci: add manual Kubernetes integration test

On GitHub open Actions → Kubernetes integration (no AWS) → Run workflow → main → Run workflow.
The workflow only runs manually and only for a public repository. Standard GitHub-hosted public-repository runner minutes are free. No cache or uploaded artifacts are used. AWS credentials are not requested, and no AWS commands or Terraform apply are run. Committing may also trigger your repository's existing validation workflows.

It builds the image for the selected commit, runs the existing unit tests, starts Kind v0.27.0 with its default Kubernetes node image, loads the local image, deploys two application replicas using the existing Helm chart and checks rollout, health, readiness, version, metrics and 404 handling. This temporary cluster does not match or validate the EKS version. The application keeps the chart's non-root user, read-only filesystem, resource limits and probes.

Ingress, autoscaling, ServiceMonitor, topology spread and NetworkPolicy are disabled only through command-line test overrides. Default Kind networking does not enforce NetworkPolicy. This run does not test AWS, ECR, ALB, Argo CD, Kyverno, Prometheus/Grafana, HPA or node scaling. Port-forward tests one selected service pod, not service load balancing or all replicas' endpoints. Both replicas must become Ready.

Logs and a summary stay on the Actions run. Download logs using the run menu if needed. The always-run cleanup deletes Kind; GitHub also discards the hosted runner after the job. On cancellation or runner failure, the cleanup step may not finish.

Evidence screenshots:
1. Run overview: workflow name, repository, successful job, commit SHA and run time.
2. Deploy and test: both ready replicas and every PASS line.
3. Diagnostics: node, two Running/Ready pods, Service and endpoints.
4. Delete temporary cluster: successful cleanup.

Suggested names: 02-kind-run-overview.png, 03-kind-endpoint-tests.png, 04-kind-resources.png, 05-kind-cleanup.png.
Keep these described as Kind integration evidence, not live AWS EKS deployment evidence. If a step fails, open that step and share the full error before continuing.