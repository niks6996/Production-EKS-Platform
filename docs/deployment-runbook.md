# Deployment runbook

## Preconditions

- Terraform validation, Helm validation, GitOps validation and security scanning are green.
- The trusted EKS API CIDR and budget notification email contain real deployment values.
- AWS credentials are supplied through an approved temporary identity, never committed keys.
- The Terraform plan has been reviewed for resource count and estimated cost.

## Sequence

1. Apply `terraform/bootstrap` once to create remote state storage.
2. Configure `terraform/environments/dev/backend.hcl` locally.
3. Plan and apply the development infrastructure.
4. Save the ECR publisher role ARN as the GitHub variable `AWS_PUBLISH_ROLE_ARN`.
5. Run the manual image-publishing workflow and record the immutable commit-SHA tag.
6. Update the Argo CD application image repository and tag.
7. Install Argo CD, apply the AppProject, then apply platform applications.
8. Verify pods, services, ingress, ALB health and monitoring targets.

## Acceptance checks

- No pods are pending or restarting.
- ALB targets are healthy and `/health` returns HTTP 200.
- `/metrics` is scraped by Prometheus and the Grafana dashboard has data.
- Kyverno blocks an intentionally insecure test manifest.
- The AWS budget exists and alert recipients are correct.