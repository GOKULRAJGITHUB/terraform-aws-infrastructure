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

## Additional Infrastructure Components

The project also includes:

- Reusable IAM module for the EC2 instance role and instance profile.
- Read-only S3 access policy scoped to the application bucket.
- CloudWatch EC2 CPU utilization alarm.
- CloudWatch log group with seven-day retention.
- GitHub Actions workflow for Terraform formatting and validation.
- S3 remote Terraform state with encryption, versioning and native locking.

### Security

The EC2 instance receives AWS permissions through an IAM instance
profile rather than storing long-lived AWS credentials on the server.
The S3 policy is restricted to the application bucket.

### Monitoring

A CloudWatch alarm monitors average EC2 CPU utilization.
The log group is provisioned for future log collection; a log
forwarding agent must be configured separately to send instance logs.

### CI

GitHub Actions checks Terraform formatting and configuration validity.
The workflow does not automatically apply infrastructure changes.
