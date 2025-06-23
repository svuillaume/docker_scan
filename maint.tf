provider "aws" {
  region = "ca-central-1"
}

resource "aws_key_pair" "samv_key" {
  key_name   = "samv-demo-only-key123"
  public_key = file("~/.ssh/id_rsa.pub")
}

data "aws_vpc" "default" {
  default = true
}

resource "aws_security_group" "samv_sg" {
  name        = "samv-demo-sg"
  description = "Allow all traffic"
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

resource "aws_instance" "samv_instance" {
  ami                    = data.aws_ami.ubuntu_old.id
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.samv_key.key_name
  vpc_security_group_ids = [aws_security_group.samv_sg.id]

  tags = {
    Name = "samv-demo-only"
  }
}
