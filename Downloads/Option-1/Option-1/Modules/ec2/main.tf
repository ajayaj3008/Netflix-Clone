resource "tls_private_key" "app_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
  
}
resource "aws_key_pair" "demo_key" {
  key_name   = "var.key_name"
  public_key = tls_private_key.app_key.public_key_openssh
}

resource "aws_instance" "demo" {
  ami           = "var.ami_id"
  instance_type = "var.instance_type"
  key_name      = "var.key_name"
  subnet_id = "var.public_subnet_id"
  vpc_security_group_ids = [var.security_group_id]

  root_block_device {
    volume_type = "gp3"
    volume_size = 30
    iops        = 3000
    throughput   = 125
    delete_on_termination = true
    encrypted = true

  }
  user_data = <<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt upgrade -y
              sudo apt install -y awscli unzip curl
              EOF  

  tags = {
    Name = "var.instance_name"
  }
}