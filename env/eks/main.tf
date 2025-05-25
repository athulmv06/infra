# Configure the AWS Provider
provider "aws" {
  profile = "default"
  region  = "us-east-1"

}

terraform {
  backend "s3" {
    bucket = "terraform-states-infra-1"
    key    = "eks/terraform_eks.tfstate"
    region = "us-east-1"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.84.0"
    }
  }
}

data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket = "terraform-states-infra-1"
    key    = "vpc/terraform_vpc.tfstate"
    region = "us-east-1"
  }
}


module "eks" {
  source = "../../modules/eks"

  environment                     = var.environment
  cluster_version                 = var.cluster_version
  authentication_mode             = var.authentication_mode
  cluster_endpoint_private_access = var.cluster_endpoint_private_access
  cluster_endpoint_public_access  = var.cluster_endpoint_public_access


  enabled_cluster_log_types = var.cluster_enabled_log_types

  cluster_addons = var.cluster_addons

  vpc_id          = data.terraform_remote_state.vpc.outputs.vpc_id
  private_subnets = data.terraform_remote_state.vpc.outputs.private_subnets
  public_subnets  = data.terraform_remote_state.vpc.outputs.public_subnets
  source_security_group_id = var.ec2_instance_sg_id
  bastion_sg_id            = var.ec2_instance_sg_id

  node_groups_key_name     = var.node_groups_key_name
  public_key               = var.node_groups_key
  disk_size                = var.disk_size
  instance_types           = var.instance_types
  node_groups_name         = var.node_groups_name
  ami_type                 = var.ami_type
  capacity_type            = var.capacity_type
  desired_size             = var.desired_size
  max_size                 = var.max_size
  min_size                 = var.min_size
  principal_arn            = var.principal_arn
}