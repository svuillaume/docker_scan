provider "aws" {
  region = "ca-central-1"
}

resource "aws_key_pair" "samv_key" {
  key_name   = "demo-only-key123"
  public_key = file("~/.ssh/id_rsa.pub")
}

data "aws_vpc" "default" {
  default = true
}

resource "aws_security_group" "samv_sg" {
  name        = "samv-demo-sg"
  description = "Allow all traffic (for testing)"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
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
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_iam_role" "samv_full_admin" {
  name = "samv-full-admin-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "admin_attach" {
  role       = aws_iam_role.samv_full_admin.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_instance_profile" "samv_admin_profile" {
  name = "samv-admin-profile"
  role = aws_iam_role.samv_full_admin.name
}

resource "aws_instance" "samv_instance" {
  ami                         = data.aws_ami.ubuntu_old.id
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.samv_key.key_name
  vpc_security_group_ids      = [aws_security_group.samv_sg.id]
  iam_instance_profile        = aws_iam_instance_profile.samv_admin_profile.name

  root_block_device {
    volume_type           = "gp2"
    volume_size           = 8
    delete_on_termination = true
    encrypted             = false
  }

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "optional"
    http_put_response_hop_limit = 1
  }

  tags = {
    Name    = "samv-demo-only"
    Purpose = "Vulnerability Testing"
  }
}
