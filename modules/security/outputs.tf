output "web_security_group_id" {
  value = aws_security_group.web.id
}

output "key_pair_name" {
  value = aws_key_pair.resume.key_name
}
