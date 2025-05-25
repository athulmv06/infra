locals {
  bastion_name = var.environment

  user_data = var.user_data

}

module "ec2_instance" {

  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.8.0"

  name = local.bastion_name

  instance_type          = var.bastion_instance_type
  key_name               = var.key_name
  ami                    = var.ami
  cpu_credits            = var.cpu_credits
  monitoring             = var.monitoring
  vpc_security_group_ids = [aws_security_group.bastion_sg.id]
  subnet_id              = var.subnet_id
  create_iam_instance_profile = var.create_iam_instance_profile

  iam_role_description        = "IAM role for EC2 instance"
  iam_role_policies = {
    AdministratorAccess = "arn:aws:iam::aws:policy/AdministratorAccess"
  }

  enable_volume_tags = var.enable_volume_tags
  root_block_device  = var.root_block_device

  user_data_base64 = base64encode(local.user_data)

  metadata_options = {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
  }

  tags = {
    Terraform   = "true"
    Environment = "bastion"
  }

}

resource "aws_security_group" "bastion_sg" {
  name   = var.bastion_sg_name
  vpc_id = var.vpc_id

  // Ingress rules
  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
      description = ingress.value.description
    }
  }

  // Egress rules
  dynamic "egress" {
    for_each = var.egress_rules
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }
}

variable "ingress_rules" {
  description = "List of ingress rules"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
    description = string
  }))
  default = []
}

variable "egress_rules" {
  description = "List of egress rules"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = []
}



resource "aws_key_pair" "bastion" {

  key_name   = var.key_name
  public_key = var.public_key
}

resource "aws_eip" "bastion" {
  instance = module.ec2_instance.id
  domain   = "vpc"
}