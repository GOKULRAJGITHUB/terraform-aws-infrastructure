variable "public_subnet_id" {
  type = string
}

variable "web_security_group" {
  type = string
}

variable "key_pair_name" {
  type = string
}


variable "iam_instance_profile_name" {
  description = "IAM instance profile attached to the EC2 instance"
  type        = string
}
