output "ec2_instance_id" {
  value = aws_instance.resume.id
}

output "ec2_public_ip" {
  value = aws_instance.resume.public_ip
}

output "resume_website_url" {
  value = "http://${aws_instance.resume.public_ip}"
}
