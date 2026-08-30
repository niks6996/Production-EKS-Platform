output "iam_policy_arn" {
  description = "ARN of the controller IAM policy."
  value       = aws_iam_policy.this.arn
}

output "iam_role_arn" {
  description = "ARN used by the controller through EKS Pod Identity."
  value       = aws_iam_role.this.arn
}

output "pod_identity_association_id" {
  description = "ID of the EKS Pod Identity association."
  value       = aws_eks_pod_identity_association.this.association_id
}