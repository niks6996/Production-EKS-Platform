# Rollback runbook

## Application rollback

1. Identify the last healthy immutable ECR image tag.
2. Revert the Git commit that changed the Argo CD image tag.
3. Confirm Argo CD synchronises the earlier desired state.
4. Verify rollout status, health probes, error rate and ALB target health.

Do not retag an existing ECR image. Every deployed version remains traceable to a Git commit.

## Infrastructure rollback

1. Stop further applies and preserve the failed plan and logs.
2. Revert the infrastructure commit through a pull request.
3. Run a new Terraform plan and review every proposed deletion.
4. Apply only after confirming state locking and the exact affected resources.

Never manually delete a Terraform-managed resource unless state recovery has been planned.