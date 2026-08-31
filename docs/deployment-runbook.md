# Deployment runbook

## Preconditions

- Terraform validation, Helm validation, GitOps validation and security scanning are green.
- The trusted EKS API CIDR and budget notification email contain real deployment values.
- AWS credentials are supplied through an approved temporary identity, never committed keys.
- The Terraform plan has been reviewed for resource count and estimated cost.
- The EKS Pod Identity Agent add-on is included for controller workload identities.
- One NAT Gateway is enabled for the temporary live deployment and scheduled for teardown.

## Sequence

1. Apply `terraform/bootstrap` once to create remote state storage.
2. Configure `terraform/environments/dev/backend.hcl` locally.
3. Copy `live.tfvars.example` to the ignored local file `live.tfvars` and replace every placeholder.
4. Run `scripts/live_preflight.sh terraform/environments/dev/live.tfvars`.
5. Run and review `terraform plan`; do not apply an unreviewed plan.
6. Apply the development infrastructure only after acknowledging the hourly charges.
7. Save the ECR publisher role ARN as the GitHub variable `AWS_PUBLISH_ROLE_ARN`.
8. Run the manual image-publishing workflow and record the immutable commit-SHA tag.
9. Update the Argo CD application image repository and tag.
10. Install Argo CD, apply the AppProject, then apply platform applications.
11. Verify pods, services, ingress, ALB health and monitoring targets.

## Acceptance checks

- No pods are pending or restarting.
- ALB targets are healthy and `/health` returns HTTP 200.
- `/metrics` is scraped by Prometheus and the Grafana dashboard has data.
- Kyverno blocks an intentionally insecure test manifest.
- The AWS budget exists and alert recipients are correct.