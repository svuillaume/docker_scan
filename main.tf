provider "aws" {
  region = "us-east-1"
}

# 1. Public S3 bucket
resource "aws_s3_bucket" "public_bucket" {
  bucket = "extremely-insecure-public-bucket-demo"
  acl    = "public-read"

  website {
    index_document = "index.html"
  }

  tags = {
    Name        = "VulnerablePublicBucket"
    Environment = "Test"
  }
}

resource "aws_s3_bucket_policy" "public_policy" {
  bucket = aws_s3_bucket.public_bucket.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Sid       = "PublicReadGetObject",
      Effect    = "Allow",
      Principal = "*",
      Action    = "s3:GetObject",
      Resource  = "${aws_s3_bucket.public_bucket.arn}/*"
    }]
  })
}

# 2. Insecure security group
resource "aws_security_group" "open_sg" {
  name        = "allow_all_inbound"
  description = "Allow everything inbound"
  vpc_id      = "vpc-xxxxxxxx" # <-- Replace with your VPC ID

  ingress {
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

# 3. EC2 with hardcoded root password and unencrypted EBS
resource "aws_instance" "vulnerable_ec2" {
  ami                    = "ami-0c02fb55956c7d316" # Amazon Linux 2 AMI (us-east-1)
  instance_type          = "t2.micro"
  subnet_id              = "subnet-xxxxxxxx" # <-- Replace with your Subnet ID
  vpc_security_group_ids = [aws_security_group.open_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              echo "root:SuperInsecurePassword123!" | chpasswd
              EOF

  root_block_device {
    volume_size = 8
    volume_type = "gp2"
    delete_on_termination = true
    encrypted = false  # <-- Unencrypted disk
  }

  tags = {
    Name = "InsecureEC2"
  }
}
