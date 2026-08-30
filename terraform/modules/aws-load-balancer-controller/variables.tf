variable "cluster_name" {
  description = "Name of the EKS cluster."
  type        = string
}

variable "namespace" {
  description = "Kubernetes namespace containing the controller service account."
  type        = string
  default     = "kube-system"
}

variable "service_account" {
  description = "Kubernetes service account used by the controller."
  type        = string
  default     = "aws-load-balancer-controller"
}

variable "policy_name" {
  description = "Name of the controller IAM policy."
  type        = string
}

variable "role_name" {
  description = "Name of the controller IAM role."
  type        = string
}

variable "tags" {
  description = "Tags applied to IAM resources."
  type        = map(string)
  default     = {}
}