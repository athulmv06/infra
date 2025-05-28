
# Cluster
variable "environment" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "sample"
}

variable "cluster_version" {
  description = "Kubernetes version to use for the EKS cluster"
  type        = string
  default     = "1.32"
}
variable "authentication_mode" {
  description = "The authentication mode for the cluster. Valid values are `CONFIG_MAP`, `API` or `API_AND_CONFIG_MAP`"
  type        = string
  default     = "API_AND_CONFIG_MAP"
}

variable "cluster_endpoint_private_access" {
  description = "Indicates whether or not the Amazon EKS private API server endpoint is enabled"
  type        = bool
  default     = true
}

variable "cluster_endpoint_public_access" {
  description = "Indicates whether or not the Amazon EKS public API server endpoint is enabled"
  type        = bool
  default     = false
}

variable "cluster_enabled_log_types" {
  description = "A list of the desired control plane logs to enable. For more information, see Amazon EKS Control Plane Logging documentation (https://docs.aws.amazon.com/eks/latest/userguide/control-plane-logs.html)"
  type        = list(string)
  default     = ["audit", "api", "authenticator", "controllerManager", "scheduler"]
}

# EKS Addons

variable "cluster_addons" {
  description = "Map of cluster addon configurations to enable for the cluster. Addon name can be the map keys or set with `name`"
  type        = any
  default = {
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
    coredns = {
      most_recent = true
    }
    aws-ebs-csi-driver = {
      most_recent = true
    }
    eks-pod-identity-agent = {
      most_recent = true
    }
  }
}

##EKS Node_Groups
variable "node_groups_name" {
  description = "node groups name"
  type        = string
  default     = "basenodes"
}

variable "min_size" {
  description = "minimum number of basenodes"
  type        = string
  default     = "1"
}

variable "max_size" {
  description = "maximum number of basenodes"
  type        = string
  default     = "1"
}

variable "desired_size" {
  description = "desired size"
  type        = string
  default     = "1"
}

variable "disk_size" {
  description = "Disk size of base nodes"
  type        = string
  default     = "30"
}

variable "ami_type" {
  description = "Type of ami for the basenodes"
  type        = string
  default     = "AL2_x86_64"
}


variable "instance_types" {
  description = "instance types of basenodes"
  type        = string
  default     = "m5.2xlarge"
}

variable "capacity_type" {
  description = "capacity type of basenodes"
  type        = string
  default     = "ON_DEMAND"
}

variable "node_groups_key_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "deployer"
}

variable "node_groups_key" {
  description = "bastion public_key"
  type        = string
}

variable "principal_arn" {
  description = "The ARN of the IAM role for the admin user"
  type        = string
  default     = "arn:aws:iam::867852670857:user/athulmv"
}
variable "node_subnet_ids" {
  description = "Type of ami for the basenodes"
  type        = string
  default     = "subnet-0bbf0c5dbae473c0as"
}

