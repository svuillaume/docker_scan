provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "bad_bucket" {
  bucket = "lacework-insecure-bucket"
  acl    = "public-read"  # ❌ Public access

  versioning {
    enabled = false  # ❌ No versioning
  }
}

resource "aws_security_group" "bad_sg" {
  name        = "open-sg"
  description = "Allows all inbound traffic"  # ❌ Overly permissive
  vpc_id      = "vpc-12345678"

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]  # ❌ Open to the world
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "bad_instance" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"

  user_data = <<EOF
#!/bin/bash
echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config
service ssh restart
EOF
  # ❌ Enables SSH password login

  tags = {
    Name = "lacework-bad-instance"
  }
}
 