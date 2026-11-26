variable "aws_region" {
  description = "AWS deployment region"
  type        = string
  default     = "ap-south-1"
}

variable "bucket_name" {
  description = "Existing S3 bucket name"
  type        = string
}

variable "ssh_allowed_cidr" {
  description = "Public IPv4 CIDR allowed to access SSH"
  type        = string
  default     = "42.104.210.136/32"
}

variable "public_key_path" {
  description = "Local path to SSH public key"
  type        = string
  default     = "~/.ssh/terraform-resume-key.pub"
}
