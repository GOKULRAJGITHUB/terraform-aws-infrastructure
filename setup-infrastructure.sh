
#!/usr/bin/env bash
set -euo pipefail

echo "Updating Terraform networking configuration..."

cat > networking.tf <<'EOF'
# Discover available Availability Zones
data "aws_availability_zones" "available" {
  state = "available"
}

# VPC
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = "terraform-resume-vpc"
    Environment = "Learning"
    Project     = "Terraform-AWS"
  }
}

# Public Subnet
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "terraform-public-subnet"
    Type = "Public"
  }
}

# Private Subnet
resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = data.aws_availability_zones.available.names[1]

  tags = {
    Name = "terraform-private-subnet"
    Type = "Private"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "terraform-resume-igw"
    Environment = "Learning"
    Project     = "Terraform-AWS"
  }
}

# Public Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "terraform-public-route-table"
  }
}

# Associate Public Route Table
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

# Private Route Table
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "terraform-private-route-table"
  }
}

# Associate Private Route Table
resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}

# Web Server Security Group
resource "aws_security_group" "web" {
  name        = "terraform-resume-web-sg"
  description = "Allow HTTP and HTTPS web traffic"
  vpc_id      = aws_vpc.main.id

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
EOF

echo "Adding useful outputs..."

add_output() {
  local name="$1"
  local block="$2"

  if ! grep -q "output \"$name\"" outputs.tf; then
    printf '\n%s\n' "$block" >> outputs.tf
  fi
}

add_output "internet_gateway_id" '
output "internet_gateway_id" {
  description = "Internet Gateway ID"
  value       = aws_internet_gateway.main.id
}'

add_output "public_route_table_id" '
output "public_route_table_id" {
  description = "Public route table ID"
  value       = aws_route_table.public.id
}'

add_output "private_route_table_id" '
output "private_route_table_id" {
  description = "Private route table ID"
  value       = aws_route_table.private.id
}'

add_output "web_security_group_id" '
output "web_security_group_id" {
  description = "Web security group ID"
  value       = aws_security_group.web.id
}'

echo "Formatting Terraform files..."
terraform fmt -recursive

echo "Validating Terraform configuration..."
terraform validate

echo "Generating Terraform plan..."
terraform plan

echo "Finished. Review the plan before running terraform apply."
