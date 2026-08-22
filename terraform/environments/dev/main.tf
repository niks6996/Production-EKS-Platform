locals {
  name_prefix = "${var.project_name}-${var.environment}"

  common_tags = {
    Environment = var.environment
    ManagedBy   = "Terraform"
    Project     = var.project_name
  }
}

module "vpc" {
  source = "../../modules/vpc"

  name_prefix        = local.name_prefix
  vpc_cidr           = var.vpc_cidr
  public_subnets     = var.public_subnets
  private_subnets    = var.private_subnets
  enable_nat_gateway = var.enable_nat_gateway
  tags               = local.common_tags
}

module "ecr" {
  source = "../../modules/ecr"

  repository_name               = "${local.name_prefix}-app"
  untagged_image_retention_days = var.ecr_untagged_retention_days
  tagged_image_count            = var.ecr_tagged_image_count
  tags                          = local.common_tags
}

module "eks" {
  source = "../../modules/eks"

  cluster_name           = "${local.name_prefix}-cluster"
  kubernetes_version     = var.kubernetes_version
  private_subnet_ids     = module.vpc.private_subnet_ids
  endpoint_public_access = var.eks_endpoint_public_access
  public_access_cidrs    = var.eks_public_access_cidrs
  access_entries         = var.eks_access_entries
  tags                   = local.common_tags
}