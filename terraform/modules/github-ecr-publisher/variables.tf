variable "github_repository" {
  description = "GitHub repository in owner/name format."
  type        = string

  validation {
    condition     = can(regex("^[A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+$", var.github_repository))
    error_message = "github_repository must use the owner/name format."
  }
}

variable "ecr_repository_arn" {
  description = "ARN of the ECR repository receiving images."
  type        = string
}

variable "role_name" {
  description = "Name of the IAM role assumed by GitHub Actions."
  type        = string
}

variable "tags" {
  description = "Tags applied to IAM resources."
  type        = map(string)
  default     = {}
}