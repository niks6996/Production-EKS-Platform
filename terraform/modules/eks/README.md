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

## Managed worker nodes

- Dedicated EC2 IAM role with EKS, ECR, networking and Session Manager permissions
- Managed node group in private subnets
- Encrypted GP3 root volumes
- IMDSv2 tokens required
- No SSH key or public remote-access configuration
- Controlled scaling from one to two development nodes
- Rolling updates limited to one unavailable node