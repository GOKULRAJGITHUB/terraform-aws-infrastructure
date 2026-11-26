output "vpc_id" {
  value = module.networking.vpc_id
}

output "vpc_cidr" {
  value = module.networking.vpc_cidr
}

output "public_subnet_id" {
  value = module.networking.public_subnet_id
}

output "private_subnet_id" {
  value = module.networking.private_subnet_id
}

output "internet_gateway_id" {
  value = module.networking.internet_gateway_id
}

output "public_route_table_id" {
  value = module.networking.public_route_table_id
}

output "private_route_table_id" {
  value = module.networking.private_route_table_id
}

output "web_security_group_id" {
  value = module.security.web_security_group_id
}

output "ec2_key_pair_name" {
  value = module.security.key_pair_name
}

output "s3_bucket_name" {
  value = module.storage.s3_bucket_name
}

output "s3_bucket_arn" {
  value = module.storage.s3_bucket_arn
}

output "ec2_instance_id" {
  value = module.compute.ec2_instance_id
}

output "ec2_public_ip" {
  value = module.compute.ec2_public_ip
}

output "resume_website_url" {
  value = module.compute.resume_website_url
}
