variable "kubernetes_version" {
  description = "Kubernetes minor version used by the development EKS cluster."
  type        = string
  default     = "1.33"
}

variable "eks_endpoint_public_access" {
  description = "Whether the EKS API has a restricted public endpoint."
  type        = bool
  default     = true
}

variable "eks_public_access_cidrs" {
  description = "Trusted IPv4 CIDR blocks allowed to reach the public EKS API endpoint."
  type        = list(string)
  default     = ["203.0.113.10/32"]
}

variable "eks_access_entries" {
  description = "IAM principals granted access to the development EKS cluster."
  type = map(object({
    principal_arn     = string
    policy_arn        = string
    access_scope_type = string
    namespaces        = optional(list(string), [])
  }))
  default = {}
}