resource "aws_iam_policy" "AwsEBSCSIdriverPolicyNew" {
  name        = "AwsEBSCSIdriverPolicyNew"
  path        = "/"
  description = "EBS_CSI-volume create"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "ec2:CreateSnapshot",
          "ec2:AttachVolume",
          "ec2:DetachVolume",
          "ec2:ModifyVolume",
          "ec2:DescribeAvailabilityZones",
          "ec2:DescribeInstances",
          "ec2:DescribeSnapshots",
          "ec2:DescribeTags",
          "ec2:DescribeVolumes",
          "ec2:DescribeVolumesModifications"
        ],
        "Resource" : "*"
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "ec2:CreateTags"
        ],
        "Resource" : [
          "arn:aws:ec2:*:*:volume/*",
          "arn:aws:ec2:*:*:snapshot/*"
        ],
        "Condition" : {
          "StringEquals" : {
            "ec2:CreateAction" : [
              "CreateVolume",
              "CreateSnapshot"
            ]
          }
        }
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "ec2:DeleteTags"
        ],
        "Resource" : [
          "arn:aws:ec2:*:*:volume/*",
          "arn:aws:ec2:*:*:snapshot/*"
        ]
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "ec2:CreateVolume"
        ],
        "Resource" : "*",
        "Condition" : {
          "StringLike" : {
            "aws:RequestTag/ebs.csi.aws.com/cluster" : "true"
          }
        }
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "ec2:CreateVolume"
        ],
        "Resource" : "*",
        "Condition" : {
          "StringLike" : {
            "aws:RequestTag/CSIVolumeName" : "*"
          }
        }
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "ec2:CreateVolume"
        ],
        "Resource" : "*",
        "Condition" : {
          "StringLike" : {
            "aws:RequestTag/kubernetes.io/cluster/*" : "owned"
          }
        }
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "ec2:DeleteVolume"
        ],
        "Resource" : "*",
        "Condition" : {
          "StringLike" : {
            "ec2:ResourceTag/ebs.csi.aws.com/cluster" : "true"
          }
        }
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "ec2:DeleteVolume"
        ],
        "Resource" : "*",
        "Condition" : {
          "StringLike" : {
            "ec2:ResourceTag/CSIVolumeName" : "*"
          }
        }
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "ec2:DeleteVolume"
        ],
        "Resource" : "*",
        "Condition" : {
          "StringLike" : {
            "ec2:ResourceTag/kubernetes.io/cluster/*" : "owned"
          }
        }
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "ec2:DeleteSnapshot"
        ],
        "Resource" : "*",
        "Condition" : {
          "StringLike" : {
            "ec2:ResourceTag/CSIVolumeSnapshotName" : "*"
          }
        }
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "ec2:DeleteSnapshot"
        ],
        "Resource" : "*",
        "Condition" : {
          "StringLike" : {
            "ec2:ResourceTag/ebs.csi.aws.com/cluster" : "true"
          }
        }
      }
    ]
  })
}

resource "aws_key_pair" "deployer" {
  key_name   = var.node_groups_key_name
  public_key = var.public_key
}

locals {
  environment  = format("%s", var.environment)
  cluster_name = format("%s", var.environment)
}



module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.33.1"

  cluster_name                    = local.cluster_name
  cluster_version                 = var.cluster_version
  authentication_mode             = var.authentication_mode
  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = false

  cluster_addons = var.cluster_addons

  cluster_enabled_log_types = var.enabled_cluster_log_types

  vpc_id                    = var.vpc_id
  subnet_ids                = concat(var.private_subnets, var.public_subnets)
  cluster_encryption_config = {}

  cluster_security_group_additional_rules = {
    ingress_bastion_sg = {
      description              = "Allow all traffic from bastion_sg"
      protocol                 = "tcp"
      from_port                = 0
      to_port                  = 65535
      type                     = "ingress"
      source_security_group_id = var.source_security_group_id

    }
  }


  eks_managed_node_groups = {
    basenodes = {
      name            = var.node_groups_name
      node_group_name = var.node_groups_name
      min_size        = var.min_size
      desired_size    = var.desired_size
      max_size        = var.max_size
      disk_size       = var.disk_size

      ami_type = var.ami_type

      instance_types = [var.instance_types]
      capacity_type  = var.capacity_type
      availability_zones = ["us-east-1a", "us-east-1b"]



      subnet_ids = var.private_subnets

      use_custom_launch_template = false
      remote_access = {
        ec2_ssh_key               = aws_key_pair.deployer.key_name #"deployer-key"\
        source_security_group_ids = [var.bastion_sg_id]

      }
      iam_role_additional_policies = {
        policy1 = aws_iam_policy.AwsEBSCSIdriverPolicyNew.arn
      }
      Tag = {
        name = var.node_groups_name
      }
    }
  }

  tags = {
    Environment = local.environment
    Terraform   = "true"
  }
}

resource "aws_eks_access_entry" "admin" {
  cluster_name      = local.cluster_name
  principal_arn     = var.principal_arn
  kubernetes_groups = ["masters"]
  type              = "STANDARD"
  depends_on        = [module.eks]
}

resource "aws_eks_access_policy_association" "admin" {
  cluster_name  = local.cluster_name
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
  principal_arn = var.principal_arn
  depends_on    = [module.eks]

  access_scope {
    type = "cluster"
  }
}