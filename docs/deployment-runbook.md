# Deployment runbook

## Preconditions

- Review Terraform, Helm, GitOps and security validation results.
- Review current AWS pricing, service availability and account quotas.
- Configure the trusted EKS API CIDR and budget notification email.
- Use an approved temporary AWS identity. Never commit credentials.
- Configure the EKS Pod Identity Agent and controller identity associations.
- Plan the deployment window and teardown. The development environment uses
  a NAT Gateway and other resources that may incur charges.
- Review the Terraform plan before applying it.

## Deploy the infrastructure

1. Apply `terraform/bootstrap` if the remote state storage does not exist.
2. Configure `terraform/environments/dev/backend.hcl` locally and initialise
   the development Terraform directory.
3. Copy `live.tfvars.example` to the ignored local file `live.tfvars`.
   Replace the placeholders with the current deployment values.
4. Run the preflight checks described in the repository.
5. Create and review a fresh Terraform plan.
6. Apply the reviewed plan.
7. Record the new ECR repository URL, VPC ID and other required outputs.
8. Configure `kubectl` for the new EKS cluster and verify the worker nodes
   and `kube-system` pods.

## Publish the application image

1. Configure the GitHub variable `AWS_PUBLISH_ROLE_ARN` with the current
   ECR publisher role ARN.
2. Run the manual image-publishing workflow.
3. Record the published ECR repository and commit-SHA tag.
4. Update the image repository and tag in `argocd/application.yaml`.

Publishing an image does not automatically update the Argo CD Application.

## Install the platform

1. Install Argo CD and verify its pods are ready.
2. Apply `argocd/project.yaml`.
3. Update the VPC ID in
   `argocd/aws-load-balancer-controller-application.yaml` using the current
   Terraform output. Apply the Application and verify the controller is ready.
4. Apply `argocd/monitoring-application.yaml`. Create the Grafana admin
   credentials Secret using the expected name and keys, then verify the
   monitoring components. Do not commit credentials.
5. Apply `argocd/metrics-server-application.yaml` and verify metrics are
   available.
6. Apply `argocd/application.yaml` and verify the API pods and Ingress.
7. Apply `argocd/cluster-autoscaler-application.yaml`.
8. Apply `argocd/kyverno-application.yaml`, verify Kyverno is ready, then
   apply `argocd/security-policies-application.yaml`.

Check each Application and its pods before moving to dependent components.
Allow time for the ALB and its targets to become healthy.

## Acceptance checks

- The EKS workers are Ready and the relevant platform pods are healthy.
- Argo CD Applications report the expected sync and health status.
- ALB targets are healthy and `/health` and `/ready` return HTTP 200.
- Prometheus scrapes the application and the Grafana dashboard has data.
- The HPA can read CPU metrics.
- Kyverno denies an intentionally noncompliant test pod in a server-side
  dry run.
- The AWS budget exists and notification recipients are correct.

For teardown, follow the
[cost and teardown runbook](cost-and-teardown-runbook.md). Remove the
application and confirm the ALB has been deleted before destroying the
cluster. The Terraform state bootstrap resources are managed separately.