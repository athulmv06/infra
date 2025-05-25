variable "key_name" {
  description = "Name of the Bastion SSH key pair."
  type        = string
}

variable "bastion_sg_name" {
  description = "Name of the Bastion security group."
  type        = string
}

variable "user_data" {
  description = "User data script for configuring the Bastion instance."
  type        = string
}

variable "bastion_instance_type" {
  description = "EC2 instance type for the Bastion host (e.g., t2.micro, t3.medium)."
  type        = string
}

variable "environment" {
  description = "Environment name (e.g., dev, prod)."
  type        = string
}

variable "monitoring" {
  description = "Enable/disable detailed monitoring for the Bastion instance."
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where the Bastion instance will be deployed."
  type        = string
}

variable "ami" {
  description = "AMI ID (e.g., Ubuntu or Amazon Linux) for the Bastion instance."
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID for the Bastion instance."
  type        = string
}

variable "public_key" {
  description = "Public SSH key to access the Bastion instance."
  type        = string
}

variable "cpu_credits" {
  description = "CPU credit configuration for burstable instance types (e.g., t2.micro)."
  type        = string
}

variable "enable_volume_tags" {
  description = "Whether to enable tags on the EBS volume."
  type        = bool
  default     = false
}

variable "root_block_device" {
  description = "Configuration for the root block device (EBS volume)."
  type = list(object({
    encrypted   = bool
    volume_type = string
    throughput  = number
    volume_size = number
    tags        = map(string)
  }))
}

variable "create_iam_instance_profile" {
  description = "IAM instance profile to associate with the Bastion instance."
  type        = string
}
