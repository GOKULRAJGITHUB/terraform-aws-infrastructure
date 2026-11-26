resource "aws_security_group" "web" {
  name        = "terraform-resume-web-sg"
  description = "Allow HTTP and HTTPS web traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow SSH only from my current public IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.ssh_allowed_cidr]
  }

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "terraform-resume-web-sg"
    Environment = "Learning"
    Project     = "Terraform-AWS"
  }
}

resource "aws_key_pair" "resume" {
  key_name   = "terraform-resume-key"
  public_key = file(pathexpand(var.public_key_path))

  tags = {
    Name        = "terraform-resume-key"
    Environment = "Learning"
    Project     = "Terraform-AWS"
  }
}
