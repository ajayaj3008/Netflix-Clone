locals {
  instance_names = [
    "jenkins-server",
    "kubernetes-master",
    "kubernetes-worker",
    "monitoring-server"
  ]
}

resource "aws_instance" "ec2" {
  count                  = var.infra_count
  ami                    = data.aws_ami.ami.id
  subnet_id              = aws_subnet.public-subnet[count.index].id
  instance_type          = var.ec2_instance_type[count.index]
  vpc_security_group_ids = [aws_security_group.name.id]
  iam_instance_profile   = aws_iam_instance_profile.iam-instance-profile.name
  root_block_device {
    volume_size = var.ec2_volume_size
    volume_type = var.ec2_volume_type
  }

  tags = {
    Name = "${local.instance_names[count.index]}"
  }

}