data "aws_vpc" "tech-challenge-vpc" {
  id = var.vpc_id
}

data "aws_subnets" "tech-challenge-subnet" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.tech-challenge-vpc.id]
  }
  
}

data "aws_subnet" "selected-subnet" {
#  for_each = toset(data.aws_subnets.tech-challenge-subnet.ids)
 id = tolist(data.aws_subnets.tech-challenge-subnet.ids)[0]
}

output "subnet_cidr_blocks" {
  value = data.aws_subnet.selected-subnet.cidr_block
}

data "aws_ecs_cluster" "ecs-mongo" {
  cluster_name = var.ecs_cluster
}

data "template_cloudinit_config" "mongodb_user_data" {

  part {
    filename     = "init.sh"
    content_type = "text/x-shellscript"
    content      = local.user_data
  }
}

data "aws_ami" "amzlinux2" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-ecs-hvm-*-x86_64*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"]
}
