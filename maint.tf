resource "aws_instance" "bad_ec2" {
  ami                    = "ami-0c55b159cbfafe1f0"
  instance_type          = "t2.micro"
  associate_public_ip_address = true  # <-- public IP triggers critical
}
