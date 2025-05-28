variable "key_name" {
  description = "Name of the EC2 key pair to be used for the Bastion host."
  type        = string
  default     = "infra-bastion-key-1"
}

variable "bastion_sg_name" {
  description = "Name of the Security Group to be created or used for the Bastion host."
  type        = string
  default     = "bastion-1"
}

variable "user_data" {
  description = "User data script to be passed to the Bastion EC2 instance at launch."
  type        = string
}

variable "bastion_instance_type" {
  description = "EC2 instance type for the Bastion host."
  type        = string
  default     = "t3.micro"
}

variable "environment" {
  description = "Environment name tag to be applied to Bastion resources (e.g., dev, staging, prod)."
  type        = string
  default     = "infra"
}

variable "monitoring" {
  description = "Enable detailed monitoring on the Bastion instance (true/false)."
  type        = string
  default     = "true"
}

variable "ami" {
  description = "AMI ID to be used for launching the Bastion EC2 instance."
  type        = string
  default     = "ami-0f9de6e2d2f067fca"
}

variable "public_key" {
  description = "Public SSH key to be added to the Bastion instance for SSH access."
  type        = string
}

variable "cpu_credits" {
  description = "CPU credit option for burstable performance instances (e.g., standard or unlimited)."
  type        = string
  default     = "standard"
}

variable "enable_volume_tags" {
  description = "Flag to enable tagging on the EBS root volume (true/false)."
  type        = bool
  default     = false
}

variable "create_iam_instance_profile" {
  description = "Flag to determine whether an IAM instance profile should be created (true/false as string)."
  type        = string
  default     = "true"
}

variable "root_block_device" {
  description = "Root block device configuration for the Bastion EC2 instance."
  type = list(object({
    encrypted   = bool
    volume_type = string
    throughput  = number
    volume_size = number
    tags        = map(string)
  }))
  default = [
    {
      encrypted   = true
      volume_type = "gp3"
      throughput  = 200
      volume_size = 30
      tags = {
        Name = "bastion"
      }
    }
  ]
}
