variable "cluster_name" {
  description = "Name of the EKS cluster."
  type        = string

  validation {
    condition     = can(regex("^[0-9A-Za-z][A-Za-z0-9_-]{0,99}$", var.cluster_name))
    error_message = "The cluster name must meet the Amazon EKS naming requirements."
  }
}

variable "kubernetes_version" {
  description = "Kubernetes minor version used by the EKS control plane."
  type        = string
  default     = "1.33"
}

variable "private_subnet_ids" {
  description = "Private subnet IDs used by the EKS control plane."
  type        = list(string)

  validation {
    condition     = length(var.private_subnet_ids) >= 2
    error_message = "EKS requires private subnets in at least two Availability Zones."
  }
}

variable "endpoint_public_access" {
  description = "Whether the Kubernetes API endpoint is reachable from approved public CIDRs."
  type        = bool
  default     = true
}

variable "public_access_cidrs" {
  description = "IPv4 CIDR blocks allowed to reach the public Kubernetes API endpoint."
  type        = list(string)
  default     = ["203.0.113.10/32"]

  validation {
    condition     = alltrue([for cidr in var.public_access_cidrs : can(cidrnetmask(cidr))])
    error_message = "Every public-access entry must be a valid IPv4 CIDR block."
  }
}

variable "log_retention_days" {
  description = "Number of days to retain EKS control-plane logs."
  type        = number
  default     = 30
}

variable "cluster_addons" {
  description = "Amazon EKS managed add-ons installed in the cluster."
  type        = list(string)
  default = [
    "coredns",
    "kube-proxy",
    "vpc-cni"
  ]
}

variable "access_entries" {
  description = "IAM principals granted Kubernetes API access through EKS access entries."
  type = map(object({
    principal_arn     = string
    policy_arn        = string
    access_scope_type = string
    namespaces        = optional(list(string), [])
  }))
  default = {}

  validation {
    condition = alltrue([
      for entry in values(var.access_entries) :
      contains(["cluster", "namespace"], entry.access_scope_type)
    ])
    error_message = "The access scope type must be cluster or namespace."
  }
}

variable "environment" {
  description = "Environment label applied to managed worker nodes."
  type        = string
}

variable "node_instance_types" {
  description = "EC2 instance types available to the managed node group."
  type        = list(string)
  default     = ["t3.medium"]
}

variable "node_capacity_type" {
  description = "Capacity type used by the managed node group."
  type        = string
  default     = "ON_DEMAND"

  validation {
    condition     = contains(["ON_DEMAND", "SPOT"], var.node_capacity_type)
    error_message = "The node capacity type must be ON_DEMAND or SPOT."
  }
}

variable "node_disk_size" {
  description = "Encrypted GP3 root-volume size in GiB."
  type        = number
  default     = 30
}

variable "node_desired_size" {
  description = "Initial desired number of worker nodes."
  type        = number
  default     = 1
}

variable "node_min_size" {
  description = "Minimum number of worker nodes."
  type        = number
  default     = 1
}

variable "node_max_size" {
  description = "Maximum number of worker nodes."
  type        = number
  default     = 2
}

variable "tags" {
  description = "Tags applied to supported EKS resources."
  type        = map(string)
  default     = {}
}