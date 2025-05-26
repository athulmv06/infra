
variable "create_vpc" {
  description = "Whether to create a new VPC"
  type        = bool
  default     = true
}

variable "environment" {
  description = "Environment name used for tagging and naming resources"
  type        = string
}

variable "cidr_slash16" {
  description = "The first two octets of the CIDR block (e.g., 10.0)"
  type        = string
}

variable "azs" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "region" {
  description = "AWS region for the deployment"
  type        = string
}

variable "enable_nat_gateway" {
  description = "Whether to create NAT Gateways"
  type        = bool
  default     = true
}

variable "create_igw" {
  description = "Whether to create an Internet Gateway"
  type        = bool
  default     = true
}

variable "create_egress_only_igw" {
  description = "Whether to create an Egress-Only Internet Gateway for IPv6"
  type        = bool
  default     = false
}

variable "enable_ipv6" {
  description = "Whether to enable IPv6"
  type        = bool
  default     = false
}

variable "ipv6_cidr" {
  description = "Optional IPv6 CIDR block"
  type        = string
  default     = null
}

variable "manage_default_network_acl" {
  description = "Whether to manage the default network ACL"
  type        = bool
  default     = false
}

variable "default_network_acl_name" {
  description = "Name for the default network ACL"
  type        = string
  default     = "default-nacl"
}

variable "default_network_acl_ingress" {
  description = "Ingress rules for the default network ACL"
  type        = list(map(string))
  default = [
    {
      rule_no    = "100"
      action     = "allow"
      protocol   = "-1"
      cidr_block = "0.0.0.0/0"
      from_port  = "0"
      to_port    = "0"
    }
  ]
}

variable "default_network_acl_egress" {
  description = "Egress rules for the default network ACL"
  type        = list(map(string))
  default = [
    {
      rule_no    = "100"
      action     = "allow"
      protocol   = "-1"
      cidr_block = "0.0.0.0/0"
      from_port  = "0"
      to_port    = "0"
    }
  ]
}

variable "default_network_acl_tags" {
  description = "Tags for the default network ACL"
  type        = map(string)
  default     = {
    "Name" = "default-nacl"
  }
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {
    Terraform   = "true"
    Environment = "infra"
  }
}
