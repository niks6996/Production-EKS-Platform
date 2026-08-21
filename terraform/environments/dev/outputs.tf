output "vpc_id" {
  description = "ID of the development VPC."
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "IDs of the public subnets."
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "IDs of the private subnets."
  value       = module.vpc.private_subnet_ids
}

output "nat_gateway_id" {
  description = "ID of the development NAT gateway when enabled."
  value       = module.vpc.nat_gateway_id
}

output "ecr_repository_arn" {
  description = "ARN of the application ECR repository."
  value       = module.ecr.repository_arn
}

output "ecr_repository_url" {
  description = "URL of the application ECR repository."
  value       = module.ecr.repository_url
}