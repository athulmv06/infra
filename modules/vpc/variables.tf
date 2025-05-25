variable "create_vpc" {
  description = "Flag to determine whether a new VPC should be provisioned"
  type        = bool
  default     = true
}

variable "environment" {
  description = "Environment name used as a prefix for resource naming (e.g., dev, prod)"
  type        = string
}

variable "cidr_slash16" {
  description = "Base CIDR block in slash16 format used to construct VPC and subnet ranges (e.g., 10.0)"
  type        = string
}

variable "azs" {
  description = "List of availability zones to be used for resource distribution"
  type        = list(string)
}

variable "region" {
  description = "AWS region where resources will be deployed"
  type        = string
}

variable "enable_ipv6" {
  description = "Enable IPv6 CIDR block assignment for the VPC"
  type        = bool
  default     = false
}

variable "ipv6_cidr" {
  description = "Optional IPv6 CIDR block to assign, either directly or via IPAM"
  type        = string
  default     = null
}

variable "tags" {
  description = "Common tags applied to all created resources"
  type        = map(string)
  default     = {}
}

# Internet Gateway
variable "create_igw" {
  description = "Whether to create an Internet Gateway for public subnets"
  type        = bool
  default     = true
}

variable "create_egress_only_igw" {
  description = "Whether to create an Egress-Only Internet Gateway for IPv6 traffic"
  type        = bool
  default     = true
}

# NAT Gateway
variable "enable_nat_gateway" {
  description = "Provision NAT Gateways to enable outbound internet access for private subnets"
  type        = bool
  default     = true
}

# Default Network ACL
variable "manage_default_network_acl" {
  description = "Manage and customize the default network ACL for the VPC"
  type        = bool
}

variable "default_network_acl_name" {
  description = "Name tag for the default network ACL"
  type        = string
}

variable "default_network_acl_ingress" {
  description = "List of ingress rules to apply to the default network ACL"
  type        = list(map(string))
}

variable "default_network_acl_egress" {
  description = "List of egress rules to apply to the default network ACL"
  type        = list(map(string))
}

variable "default_network_acl_tags" {
  description = "Custom tags for the default network ACL resource"
  type        = map(string)
}
