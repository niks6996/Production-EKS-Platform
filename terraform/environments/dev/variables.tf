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

variable "ecr_untagged_retention_days" {
  description = "Number of days to retain untagged application images."
  type        = number
  default     = 7
}

variable "ecr_tagged_image_count" {
  description = "Maximum number of application release images to retain."
  type        = number
  default     = 20
}

variable "monthly_budget_limit_usd" {
  description = "Monthly AWS account budget limit in US dollars."
  type        = number
  default     = 75

  validation {
    condition     = var.monthly_budget_limit_usd >= 10
    error_message = "The monthly budget limit must be at least USD 10."
  }
}

variable "budget_alert_email" {
  description = "Email address receiving AWS budget alerts. Supply a real address only for live deployment."
  type        = string

  validation {
    condition     = can(regex("^[^@\\s]+@[^@\\s]+\\.[^@\\s]+$", var.budget_alert_email))
    error_message = "budget_alert_email must be a valid email address."
  }
}