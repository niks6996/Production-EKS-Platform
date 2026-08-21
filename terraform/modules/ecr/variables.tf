variable "repository_name" {
  description = "Name of the ECR repository."
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9]+(?:[._/-][a-z0-9]+)*$", var.repository_name))
    error_message = "The repository name must use lowercase letters, numbers and supported separators."
  }
}

variable "untagged_image_retention_days" {
  description = "Number of days to retain untagged images."
  type        = number
  default     = 7

  validation {
    condition     = var.untagged_image_retention_days >= 1
    error_message = "The untagged image retention period must be at least one day."
  }
}

variable "tagged_image_count" {
  description = "Maximum number of matching tagged images to retain."
  type        = number
  default     = 20

  validation {
    condition     = var.tagged_image_count >= 1
    error_message = "At least one tagged image must be retained."
  }
}

variable "tags" {
  description = "Tags applied to the ECR repository."
  type        = map(string)
  default     = {}
}