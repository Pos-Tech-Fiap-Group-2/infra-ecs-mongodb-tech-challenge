resource "aws_lb" "mongodb_lb" {
  count              = var.nlb_enabled ? 1 : 0
  name               = var.mongodb-lb
  internal           = false
  load_balancer_type = "network"
  subnets            = data.aws_subnets.tech-challenge-subnet.ids

}
