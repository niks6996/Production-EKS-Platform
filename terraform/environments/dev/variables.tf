variable "aws_region" {
  description = "AWS region used by the development environment."
  type        = string
  default     = "eu-west-2"
}

variable "project_name" {
  description = "Project identifier used in names and tags."
  type        = string
  default     = "production-eks-platform"
}

variable "environment" {
  description = "Deployment environment name."
  type        = string
  default     = "dev"
}

variable "vpc_cidr" {
  description = "IPv4 CIDR block assigned to the development VPC."
  type        = string
  default     = "10.20.0.0/16"
}

variable "public_subnets" {
  description = "Public subnet CIDR blocks keyed by Availability Zone."
  type        = map(string)
  default = {
    "eu-west-2a" = "10.20.0.0/24"
    "eu-west-2b" = "10.20.1.0/24"
  }
}

variable "private_subnets" {
  description = "Private subnet CIDR blocks keyed by Availability Zone."
  type        = map(string)
  default = {
    "eu-west-2a" = "10.20.10.0/24"
    "eu-west-2b" = "10.20.11.0/24"
  }
}

variable "enable_nat_gateway" {
  description = "Whether to create one NAT gateway for private-subnet internet egress."
  type        = bool
  default     = false
}