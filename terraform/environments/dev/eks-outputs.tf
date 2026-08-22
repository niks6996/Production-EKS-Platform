output "eks_cluster_arn" {
  description = "ARN of the development EKS cluster."
  value       = module.eks.cluster_arn
}

output "eks_cluster_endpoint" {
  description = "Endpoint of the Kubernetes API server."
  value       = module.eks.cluster_endpoint
}

output "eks_cluster_name" {
  description = "Name of the development EKS cluster."
  value       = module.eks.cluster_name
}

output "eks_oidc_issuer_url" {
  description = "OpenID Connect issuer URL for workload identity configuration."
  value       = module.eks.oidc_issuer_url
}