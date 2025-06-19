provider "aws" {
  region = "ca-central-1"
}

resource "aws_key_pair" "samv_demo_key" {
  key_name   = "samv-demo-only-key"
  public_key = file("~/.ssh/id_rsa.pub")
}

data "aws_vpc" "default" {
  default = true
}

resource "aws_security_group" "samv_demo_sg" {
  name        = "samv-demo-only-sg"
  description = "Allow SSH and HTTP (restricted)"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "SSH from my IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["YOUR_IP/32"]  # Replace this
  }

  ingress {
    description = "HTTP for test"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["172.16.31.0/24"]  # Replace this
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

data "aws_ami" "ubuntu_old" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "samv_demo_ec2" {
  ami                    = data.aws_ami.ubuntu_old.id
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.samv_demo_key.key_name
  vpc_security_group_ids = [aws_security_group.samv_demo_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              apt-get update -y
              apt-get install -y openjdk-8-jdk wget unzip

              mkdir -p /opt/samv-demo-only
              cd /opt/samv-demo-only

              wget https://github.com/christophetd/log4shell-vulnerable-app/releases/download/v0.1/vulnerable-app.jar

              nohup java -jar vulnerable-app.jar > /var/log/samv-demo-only.log 2>&1 &
              EOF

  tags = {
    Name = "samv-demo-only-instance"
  }
}
