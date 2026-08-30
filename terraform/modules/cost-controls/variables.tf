variable "budget_name" {
  description = "Name of the AWS monthly cost budget."
  type        = string
}

variable "monthly_limit_usd" {
  description = "Maximum planned monthly AWS spend in US dollars."
  type        = number
}

variable "alert_email" {
  description = "Email address receiving budget notifications."
  type        = string
  sensitive   = true
}