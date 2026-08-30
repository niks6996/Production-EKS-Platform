# AWS Load Balancer Controller identity

This module creates the IAM policy, IAM role and EKS Pod Identity association
used by the AWS Load Balancer Controller. Workloads receive temporary AWS
credentials without storing access keys in Kubernetes or Git.

The policy is based on the upstream controller policy and should be reviewed
when the pinned controller version is upgraded.