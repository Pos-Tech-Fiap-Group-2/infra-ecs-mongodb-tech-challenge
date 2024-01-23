# resource "aws_ecs_cluster" "mongodb_cluster" {
#   name = var.mongodb_cluster
#   setting {
#     name  = "containerInsights"
#     value = "enabled"
#   }
# }