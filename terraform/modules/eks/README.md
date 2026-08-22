# EKS module

This module provisions the managed Kubernetes control plane and its supporting identity and logging resources.

## Security and operations

- Dedicated least-privilege IAM role for the EKS service
- Private Kubernetes API endpoint enabled
- Public endpoint restricted to explicitly approved CIDR blocks
- Cluster-creator administrator access disabled
- IAM access managed through EKS access entries and policies
- API, audit, authenticator, controller-manager and scheduler logs enabled
- CloudWatch log retention configured explicitly
- Core EKS add-ons managed through Terraform

Managed worker nodes are intentionally implemented separately so control-plane and compute responsibilities remain clear.