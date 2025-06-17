resource "aws_instance" "bad_ec2" {
  ami                    = "ami-0c55b159cbfafe1f0"
  instance_type          = "t2.micro"
  associate_public_ip_address = true  # <-- public IP triggers critical

  user_data = <<-EOF
              #!/bin/bash
              echo "ROOT_PASSWORD=SuperSecret123" > /var/www/html/root-password.txt
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              EOF

  tags = {
    Name = "bad-ec2-exposed-password"
  }
}
