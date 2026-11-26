data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

resource "aws_instance" "resume" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t3.micro"
  subnet_id                   = var.public_subnet_id
  vpc_security_group_ids      = [var.web_security_group]
  key_name                    = var.key_pair_name
  associate_public_ip_address = true

  user_data = <<-USERDATA
    #!/bin/bash
    set -eux

    apt-get update
    apt-get install -y nginx

    cat > /var/www/html/index.html <<'HTML'
    <!DOCTYPE html>
    <html lang="en">
    <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>My Resume | Portfolio</title>
      <style>
        * { box-sizing: border-box; }
        body {
          margin: 0;
          font-family: Arial, sans-serif;
          background: #f1f5f9;
          color: #1e293b;
          line-height: 1.6;
        }
        header {
          background: #0f172a;
          color: white;
          text-align: center;
          padding: 55px 20px;
        }
        header h1 { margin: 0; font-size: 38px; }
        header p { color: #cbd5e1; }
        main {
          max-width: 850px;
          margin: 30px auto;
          padding: 0 18px;
        }
        section {
          background: white;
          padding: 25px;
          margin-bottom: 20px;
          border-radius: 12px;
          box-shadow: 0 2px 10px rgba(0,0,0,.05);
        }
        h2 { color: #2563eb; }
        footer {
          text-align: center;
          padding: 25px;
          color: #64748b;
        }
      </style>
    </head>
    <body>
      <header>
        <h1>YOUR NAME</h1>
        <p>Aspiring Cloud Engineer | AWS | Terraform | Linux</p>
      </header>
      <main>
        <section>
          <h2>About Me</h2>
          <p>Write a short professional introduction here.</p>
        </section>
        <section>
          <h2>Technical Skills</h2>
          <p>AWS, Terraform, Linux, Git, Networking, Python</p>
        </section>
        <section>
          <h2>Projects</h2>
          <h3>AWS Infrastructure with Terraform</h3>
          <p>Built a VPC, public and private subnets, Internet
          Gateway, route tables, security groups and an EC2
          web server using Infrastructure as Code.</p>
        </section>
        <section>
          <h2>Education</h2>
          <p>Add your educational details here.</p>
        </section>
        <section>
          <h2>Contact</h2>
          <p>Email: your-email@example.com</p>
          <p>LinkedIn: Add your LinkedIn profile</p>
          <p>GitHub: Add your GitHub profile</p>
        </section>
      </main>
      <footer>
        Hosted on AWS EC2 | Provisioned with Terraform
      </footer>
    </body>
    </html>
    HTML

    systemctl enable nginx
    systemctl restart nginx
  USERDATA

  root_block_device {
    volume_size           = 8
    volume_type           = "gp3"
    encrypted             = true
    delete_on_termination = true
  }

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  tags = {
    Name        = "terraform-resume-web-server"
    Environment = "Learning"
    Project     = "Terraform-AWS"
  }
}
