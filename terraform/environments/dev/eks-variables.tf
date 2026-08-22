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

variable "eks_node_instance_types" {
  description = "EC2 instance types available to the development managed node group."
  type        = list(string)
  default     = ["t3.medium"]
}

variable "eks_node_capacity_type" {
  description = "Capacity type used by development worker nodes."
  type        = string
  default     = "ON_DEMAND"
}

variable "eks_node_disk_size" {
  description = "Encrypted worker-node root-volume size in GiB."
  type        = number
  default     = 30
}

variable "eks_node_desired_size" {
  description = "Initial desired number of development worker nodes."
  type        = number
  default     = 1
}

variable "eks_node_min_size" {
  description = "Minimum number of development worker nodes."
  type        = number
  default     = 1
}

variable "eks_node_max_size" {
  description = "Maximum number of development worker nodes."
  type        = number
  default     = 2
}