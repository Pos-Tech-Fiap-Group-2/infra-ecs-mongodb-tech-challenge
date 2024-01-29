resource "aws_ecs_service" "this" {
  name        = var.name
  cluster     = var.cluster
  launch_type = "EC2"

  task_definition      = aws_ecs_task_definition.this.arn
  force_new_deployment = false
  desired_count        = var.desired_count

  network_configuration {
    subnets          = var.subnets
    security_groups  = var.security_groups
    assign_public_ip = false
  }

  deployment_maximum_percent         = 100
  deployment_minimum_healthy_percent = 0
}
