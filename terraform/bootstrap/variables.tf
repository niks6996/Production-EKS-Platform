variable "aws_region" {
  description = "AWS region used for the Terraform state bucket."
  type        = string
  default     = "eu-west-2"

  validation {
    condition     = can(regex("^[a-z]{2}-[a-z]+-[0-9]+$", var.aws_region))
    error_message = "The AWS region must use a valid format such as eu-west-2."
  }
}

variable "project_name" {
  description = "Lowercase project identifier used to name and tag shared resources."
  type        = string
  default     = "production-eks-platform"

  validation {
    condition     = can(regex("^[a-z0-9][a-z0-9-]{1,38}[a-z0-9]$", var.project_name))
    error_message = "The project name must contain 3 to 40 lowercase letters, numbers or hyphens, and cannot start or end with a hyphen."
  }
}