module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.21.0"

  name = var.environment
  cidr = "${var.cidr_slash16}.0.0/16"

  azs             = var.azs

  private_subnets = [
    "${var.cidr_slash16}.0.0/18",
    "${var.cidr_slash16}.64.0/18"
  ]

  public_subnets = [
    "${var.cidr_slash16}.192.0/19",
    "${var.cidr_slash16}.224.0/20"
  ]

  enable_nat_gateway = var.enable_nat_gateway
  create_igw         = var.create_igw

  manage_default_network_acl  = var.manage_default_network_acl
  default_network_acl_name    = var.default_network_acl_name
  default_network_acl_ingress = var.default_network_acl_ingress
  default_network_acl_egress  = var.default_network_acl_egress
  default_network_acl_tags    = var.default_network_acl_tags

  vpc_tags = {
    Name = "${var.environment}-vpc"
  }

  igw_tags = {
    Name = "${var.environment}-igw"
  }

  tags = {
    Terraform   = "true"
    Environment = var.environment
  }
}
