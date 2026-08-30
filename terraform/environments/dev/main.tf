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
  environment            = var.environment
  node_instance_types    = var.eks_node_instance_types
  node_capacity_type     = var.eks_node_capacity_type
  node_disk_size         = var.eks_node_disk_size
  node_desired_size      = var.eks_node_desired_size
  node_min_size          = var.eks_node_min_size
  node_max_size          = var.eks_node_max_size
  tags                   = local.common_tags
}

module "aws_load_balancer_controller" {
  source = "../../modules/aws-load-balancer-controller"

  cluster_name    = module.eks.cluster_name
  policy_name     = "${local.name_prefix}-aws-load-balancer-controller"
  role_name       = "${local.name_prefix}-aws-load-balancer-controller"
  service_account = "aws-load-balancer-controller"
  tags            = local.common_tags
}

module "github_ecr_publisher" {
  source = "../../modules/github-ecr-publisher"

  github_repository  = "niks6996/Production-EKS-Platform"
  ecr_repository_arn = module.ecr.repository_arn
  role_name          = "${local.name_prefix}-github-ecr-publisher"
  tags               = local.common_tags
}

module "cluster_autoscaler_identity" {
  source = "../../modules/cluster-autoscaler-identity"

  cluster_name    = module.eks.cluster_name
  role_name       = "${local.name_prefix}-cluster-autoscaler"
  service_account = "cluster-autoscaler-aws-cluster-autoscaler"
  tags            = local.common_tags
}