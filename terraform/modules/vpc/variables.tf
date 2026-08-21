variable "name_prefix" {
  description = "Prefix used for network resource names."
  type        = string
}

variable "vpc_cidr" {
  description = "IPv4 CIDR block assigned to the VPC."
  type        = string

  validation {
    condition     = can(cidrnetmask(var.vpc_cidr))
    error_message = "The VPC CIDR must be a valid IPv4 CIDR block."
  }
}

variable "public_subnets" {
  description = "Map of Availability Zones to public-subnet CIDR blocks."
  type        = map(string)

  validation {
    condition     = length(var.public_subnets) >= 2 && alltrue([for cidr in values(var.public_subnets) : can(cidrnetmask(cidr))])
    error_message = "Provide at least two public subnets with valid IPv4 CIDR blocks."
  }
}

variable "private_subnets" {
  description = "Map of Availability Zones to private-subnet CIDR blocks."
  type        = map(string)

  validation {
    condition     = length(var.private_subnets) >= 2 && alltrue([for cidr in values(var.private_subnets) : can(cidrnetmask(cidr))])
    error_message = "Provide at least two private subnets with valid IPv4 CIDR blocks."
  }
}

variable "enable_nat_gateway" {
  description = "Whether to create one NAT gateway for private-subnet internet egress."
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags applied to all supported network resources."
  type        = map(string)
  default     = {}
}