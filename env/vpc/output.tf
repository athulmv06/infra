output "vpc_id" {
  description = "Unique identifier of the created VPC"
  value       = module.vpc.vpc_id
}

output "vpc_cidr_block" {
  description = "CIDR block assigned to the VPC"
  value       = module.vpc.vpc_cidr_block
}

output "public_subnets" {
  description = "List of subnet IDs for public subnets"
  value       = module.vpc.public_subnets
}

output "private_subnets" {
  description = "List of subnet IDs for private subnets"
  value       = module.vpc.private_subnets
}

output "subnet_ids" {
  description = "Combined list of public and private subnet IDs"
  value       = concat(module.vpc.private_subnets, module.vpc.public_subnets)
}

output "azs" {
  description = "Availability zones used for subnet distribution"
  value       = module.vpc.azs
}
