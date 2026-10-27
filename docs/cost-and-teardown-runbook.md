# Cost control and teardown runbook

## Before deployment

1. Configure a budget notification email that you actively monitor.
2. Review current AWS pricing, account eligibility, quotas and instance
   availability in the chosen region.
3. Select the worker instance type and node group limits for the test.
4. Review whether private workloads require a NAT Gateway.
5. Agree a deployment window and review the Terraform plan before applying it.

AWS Budgets alerts notify recipients when configured thresholds are reached.
They do not automatically stop resources or cap spending.

## Resources that may incur charges

- EKS control plane and worker nodes.
- EC2 instances and EBS volumes.
- NAT Gateway hourly and data-processing usage.
- Application Load Balancers and associated usage.
- Public IPv4 addresses.
- CloudWatch log ingestion and retention.
- ECR image storage.
- Terraform state storage and retained object versions.

Charges depend on the account, region, usage and current pricing. Review AWS
Billing and Cost Explorer for actual costs.

## Teardown order

### 1. Remove application resources that create AWS infrastructure

Delete the Argo CD application while Argo CD and the AWS Load Balancer
Controller are still running:

```powershell
kubectl delete application platform-api -n argocd
```

Confirm that the Kubernetes Ingress is gone:

```powershell
kubectl get ingress -n platform
```

Check the AWS Console and wait until the project's ALB has disappeared.
Keep the cluster and load balancer controller running until AWS completes
the ALB cleanup.

### 2. Review and apply a fresh destroy plan

From the repository root, with the correct AWS profile and region selected:

```powershell
terraform -chdir=terraform/environments/dev plan -destroy "-var-file=live.tfvars" "-out=final-destroy.tfplan"
```

Review the resources in the plan, then apply it:

```powershell
terraform -chdir=terraform/environments/dev apply "final-destroy.tfplan"
```

Saved Terraform plans can contain sensitive values. Do not commit or share
them. If an apply fails or the infrastructure changes, generate and review
a new plan instead of reusing the old one.

### 3. Handle a nonempty ECR repository

ECR may prevent Terraform from deleting a repository that still contains
images. Decide whether the images need to be retained before deleting them.

For this temporary development environment, the repository and its images
were deleted in the AWS Console. A fresh destroy plan was then created and
applied to reconcile the remaining Terraform state.

Deleting images is irreversible. Keep the source code and build process
available if the image may need to be recreated.

### 4. Verify cleanup

Check that the development state has no remaining managed resources:

```powershell
terraform -chdir=terraform/environments/dev state list
```

In the deployment region, check for project resources including:

- EKS clusters and node groups.
- EC2 instances and unattached EBS volumes.
- Load balancers and NAT Gateways.
- Allocated public IPv4 addresses.
- ECR repositories and images.
- Other resources created outside Terraform, including relevant logs.

Check AWS Billing and Cost Explorer for remaining or delayed charges.
Do not assume that a failed Terraform command means no resources were created
or that an empty Terraform state proves every AWS resource is gone.

## Terraform bootstrap resources

The remote state bucket is managed separately under `terraform/bootstrap`.
Keep it while the project may need to be managed or redeployed.

The bucket and retained object versions may still incur storage charges.
Review its contents, encryption and cost before intentionally closing the
state lifecycle. Do not delete state or bootstrap resources as part of the
development environment teardown.