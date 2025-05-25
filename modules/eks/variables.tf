################################################################################
# Cluster Configuration
################################################################################

variable "environment" {
  description = "Specifies the deployment environment for the EKS cluster (e.g., 'dev', 'prod', 'staging'). This will also be used as part of the cluster name."
  type        = string
}

variable "cluster_version" {
  description = "The Kubernetes version to deploy on the EKS cluster (e.g., '1.28', '1.29')."
  type        = string
}

variable "authentication_mode" {
  description = "Defines how users and roles authenticate to the cluster. Options: `CONFIG_MAP` (legacy), `API` (IAM only), or `API_AND_CONFIG_MAP` (hybrid)."
  type        = string
}

variable "cluster_endpoint_private_access" {
  description = "Set to `true` to enable private access to the EKS API server endpoint within the VPC. Defaults to `false`."
  type        = bool
}

variable "cluster_endpoint_public_access" {
  description = "Set to `true` to enable public access to the EKS API server endpoint. Defaults to `true`."
  type        = bool
}

variable "vpc_id" {
  description = "The ID of the VPC where the EKS cluster will be deployed."
  type        = string
}

variable "private_subnets" {
  description = "A list of private subnet IDs where EKS worker nodes will be launched."
  type        = list(string)
}

variable "public_subnets" {
  description = "A list of public subnet IDs. Required if the EKS cluster public endpoint is enabled."
  type        = list(string)
}

variable "enabled_cluster_log_types" {
  description = "A list of EKS control plane log types to enable (e.g., `api`, `audit`, `authenticator`). For details, refer to AWS EKS documentation."
  type        = list(string)
}



### EKS Addons Configuration
variable "cluster_addons" {
  description = "A map defining the EKS cluster add-ons to enable and their configurations (e.g., coredns, kube-proxy, vpc-cni)."
  type        = any
}


### EKS Node Group Configuration

variable "node_groups_name" {
  description = "The base name for the EKS managed node group."
  type        = string
}

variable "min_size" {
  description = "The minimum number of EC2 instances in the EKS node group."
  type        = number # Changed to number type for better type enforcement
}

variable "max_size" {
  description = "The maximum number of EC2 instances allowed in the EKS node group."
  type        = number # Changed to number type
}

variable "desired_size" {
  description = "The desired number of EC2 instances for the EKS node group at launch."
  type        = number # Changed to number type
}

variable "disk_size" {
  description = "The size (in GB) of the EBS volumes attached to EKS worker nodes."
  type        = number # Changed to number type
  default     = 100
}

variable "ami_type" {
  description = "The AMI type to use for the EKS worker nodes (e.g., 'AL2_x86_64', 'BOTTLEROCKET_x86_64')."
  type        = string
  default     = "AL2_x86_64"
}

variable "instance_types" {
  description = "The EC2 instance type for the EKS worker nodes (e.g., 't3.medium', 'm5.large')."
  type        = string
}

variable "capacity_type" {
  description = "The capacity type for the node group (e.g., 'ON_DEMAND', 'SPOT')."
  type        = string
}

variable "node_groups_key_name" {
  description = "The name of the EC2 Key Pair used for SSH access to the EKS worker nodes."
  type        = string
}

variable "source_security_group_id" {
  description = "Id of the bastion security_group"
  type        = string
}

variable "bastion_sg_id" {
  description = "The Security Group ID of the bastion host, used to allow SSH access to EKS worker nodes."
  type        = string
}

variable "public_key" {
  description = "The public key material for the EC2 Key Pair. It's recommended to mark this as `sensitive`."
  type        = string
  sensitive   = true # Added sensitive flag for security
}

variable "principal_arn" {
  description = "The ARN of the IAM user or role that will be granted administrative access to the EKS cluster."
  type        = string
}