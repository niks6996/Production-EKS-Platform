# Recovery runbook

## Terraform state

The state bucket is encrypted and versioned. If state is corrupted, stop all applies, identify the last known-good S3 object version and restore it before planning again.

## Cluster recovery

1. Recreate AWS infrastructure from the reviewed Terraform configuration.
2. Restore Argo CD and apply the repository's declarative applications.
3. Publish or select a verified immutable application image.
4. Confirm policy, monitoring, autoscaling and ingress components become healthy.

Application data recovery is outside this project because the sample API is stateless. A stateful production workload would require tested database and persistent-volume backups with defined recovery objectives.