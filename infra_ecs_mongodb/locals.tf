locals {
  role_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM",
    "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  ]

  user_data = templatefile("${path.module}/template/user_template.sh", {
    ECS_CLUSTER       = var.mongodb_cluster
    REGION            = var.aws_region
    ECS_USER_PASSWORD = var.ecs_user_password

  })
}
