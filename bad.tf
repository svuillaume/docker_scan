provider "aws" {
  region = "us-east-1"
}

# 1. Public S3 bucket with no encryption
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

# 2. Unencrypted S3 bucket (no ACL, no policy, no encryption)
resource "aws_s3_bucket" "unencrypted_bucket" {
  bucket = "totally-unprotected-data-bucket"

  tags = {
    Name = "NoEncryption"
  }
}

# 3. Insecure security group open to all
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

# 4. EC2 with hardcoded root password, unencrypted disk
resource "aws_instance" "vulnerable_ec2" {
  ami                    = "ami-0c02fb55956c7d316"
  instance_type          = "t2.micro"
  subnet_id              = "subnet-xxxxxxxx" # <-- Replace with your Subnet ID
  vpc_security_group_ids = [aws_security_group.open_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              echo "root:SuperInsecurePassword123!" | chpasswd
              EOF

  root_block_device {
    volume_size           = 8
    volume_type           = "gp2"
    delete_on_termination = true
    encrypted             = false
  }

  tags = {
    Name = "InsecureEC2"
  }
}

# 5. EC2 with IMDSv1 enabled (http_tokens = optional)
resource "aws_instance" "no_imdsv2" {
  ami                    = "ami-0c02fb55956c7d316"
  instance_type          = "t2.micro"
  subnet_id              = "subnet-xxxxxxxx"
  vpc_security_group_ids = [aws_security_group.open_sg.id]

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "optional"
  }

  tags = {
    Name = "EC2WithIMDSv1"
  }
}

# 6. EC2 with hardcoded secret in user_data
resource "aws_instance" "with_env_secret" {
  ami                    = "ami-0c02fb55956c7d316"
  instance_type          = "t2.micro"
  subnet_id              = "subnet-xxxxxxxx"
  vpc_security_group_ids = [aws_security_group.open_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              export DB_PASSWORD="SuperSecret123"
              EOF

  tags = {
    Name = "EC2WithHardcodedSecret"
  }
}

# 7. IAM user and hardcoded access key (PGP optional)
resource "aws_iam_user" "insecure_user" {
  name = "insecure-user"
}

resource "aws_iam_access_key" "insecure_key" {
  user = aws_iam_user.insecure_user.name

  # Optional, still insecure
  pgp_key = "keybase:somekey"
}
