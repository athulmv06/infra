# Terraform Infrastructure Deployment

This repository contains modular Terraform code for deploying cloud infrastructure. The architecture is split into reusable components and environment-specific configurations.

## 📦 Modules

The Terraform codebase includes the following core modules:

- `vpc` – Virtual Private Cloud setup
- `bastion-ec2` – Bastion host EC2 instance for SSH access
- `eks` – Amazon Elastic Kubernetes Service (EKS) cluster

Each module is located under the `modules/` directory and is **reusable across environments**.

## 🌍 Environments

Environment-specific deployments are defined under the `environments/` directory:
