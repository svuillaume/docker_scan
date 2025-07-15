provider "aws" {
  region = "ca-central-1"
}

resource "aws_security_group" "insecure_sg" {
  name        = "insecure_sg"
  description = "Security group with wide open rules"
  vpc_id      = "vpc-12345678"  # dummy VPC

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Wide open to the world
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "InsecureSG"
  }
}

resource "aws_security_group_rule" "inbound_all" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]  # Open SSH
  security_group_id = aws_security_group.insecure_sg.id
}

resource "aws_instance" "bad_ec2" {
  ami                    = "ami-0c55b159cbfafe1f0"  # dummy AMI
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.insecure_sg.id]
  user_data              = <<EOF
#!/bin/bash
echo "SECRET=hardcodedsecretkey" > /etc/secrets.txt
EOF

  tags = {
    Name = "BadEC2Instance"
  }
}
