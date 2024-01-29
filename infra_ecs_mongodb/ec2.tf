resource "aws_instance" "mongodb_instance" {
  ami                    = var.ami_restore == null ? data.aws_ami.amzlinux2.id : var.ami_restore
  iam_instance_profile   = var.aws_instance_profile
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.mongodb_sg.id]
  subnet_id              = data.aws_subnet.selected-subnet.id

  monitoring    = true
  ebs_optimized = true

  root_block_device {
    volume_type = var.volume_type
    volume_size = var.volume_size
  }

  user_data_base64 = data.template_cloudinit_config.mongodb_user_data.rendered
  tags = {
    Name = "mongodb-instance-EC2"
  }

}
