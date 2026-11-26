# AWS Infrastructure Automation using Terraform

## Project overview
This project provisions AWS infrastructure in ap-south-1 (Mumbai)
using Terraform and reusable modules.

## Architecture
- Custom VPC with public and private subnets
- Internet Gateway and route tables
- Security group with restricted SSH access
- S3 storage with public access blocked
- Ubuntu EC2 instance running Nginx

## Terraform modules
- modules/networking: VPC, subnets, gateway and routing
- modules/security: security group and EC2 key pair
- modules/storage: S3 bucket and public access protection
- modules/compute: Ubuntu EC2 web server

## Prerequisites
- Terraform
- AWS CLI
- AWS credentials configured
- SSH public key at ~/.ssh/terraform-resume-key.pub

## Deploy
```bash
terraform init
terraform fmt -recursive
terraform validate
terraform plan
terraform apply
```

## Security
- SSH is restricted to the configured source CIDR.
- S3 public access is blocked.
- EC2 requires IMDSv2.
- EC2 root EBS volume is encrypted.

## Cleanup
Review resources before running `terraform destroy`.
