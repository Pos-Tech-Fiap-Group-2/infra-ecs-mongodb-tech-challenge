resource "aws_security_group" "mongodb_sg" {
  name        = var.mongodb_sg
  description = "Security group to Mongo"
  vpc_id      = data.aws_vpc.tech-challenge-vpc.id

  dynamic "ingress" {
    for_each = var.nlb_enabled ? [1] : []
    content {
      from_port   = var.containerPort
      to_port     = var.containerPort
      protocol    = "tcp"
      cidr_blocks = var.ingress_cidr_blocks
    }
  }

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    self      = true
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "mongodb-sg"
  }
}
