provider "aws" {
  region = "us-central-1"
}

resource "aws_iam_role" "admin_role" {
  name = "vulnerable-admin-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action    = "sts:AssumeRole",
        Effect    = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "admin_policy" {
  role       = aws_iam_role.admin_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_instance" "vulnerable_ec2" {
  ami                    = "ami-0c02fb55956c7d316" # Amazon Linux 2 AMI (us-east-1)
  instance_type          = "t2.micro"
  associate_public_ip_address = true

  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello from vulnerable instance!" > /home/ec2-user/hello.txt
              EOF

  tags = {
    Name = "vulnerable-ec2"
  }
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "vulnerable-ec2-profile"
  role = aws_iam_role.admin_role.name
}

resource "aws_security_group" "vulnerable_sg" {
  name        = "vulnerable-sg"
  description = "Allow all inbound traffic"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "All traffic"
    from_port   = 0
    to_port     = 65535
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

data "aws_vpc" "default" {
  default = true
}

resource "aws_s3_bucket" "vulnerable_bucket" {
  bucket = "vulnerable-public-bucket-${random_id.bucket_id.hex}"

  tags = {
    Name = "vulnerable-bucket"
  }
}

resource "random_id" "bucket_id" {
  byte_length = 4
}

resource "aws_s3_bucket_policy" "public_access" {
  bucket = aws_s3_bucket.vulnerable_bucket.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "PublicReadGetObject",
        Effect    = "Allow",
        Principal = "*",
        Action    = [
          "s3:GetObject"
        ],
        Resource = [
          "${aws_s3_bucket.vulnerable_bucket.arn}/*"
        ]
      }
    ]
  })
}
