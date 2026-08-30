# Cost control and teardown runbook

## Before deployment

1. Replace the example budget email with an address you actively monitor.
2. Keep the NAT gateway disabled until private workloads need internet access.
3. Keep the managed node group between one and two `t3.medium` nodes.
4. Review the Terraform plan before approving any apply.

## Chargeable resources

- EKS control plane
- EC2 worker nodes and EBS volumes
- NAT gateway hourly and data-processing usage when enabled
- Application Load Balancer hourly and capacity usage
- CloudWatch log ingestion and retention

## Teardown order

1. Delete Kubernetes Ingress resources and confirm the ALB is removed.
2. Remove Argo CD-managed workloads that create AWS resources.
3. Run `terraform destroy` from the development environment.
4. Confirm that EKS, EC2, ALB and NAT Gateway consoles contain no project resources.
5. Keep the versioned Terraform state bucket unless the state lifecycle is intentionally closed.

Never assume a failed Terraform command means resources were not created. Verify
the AWS console and billing dashboard after both deployment and teardown.