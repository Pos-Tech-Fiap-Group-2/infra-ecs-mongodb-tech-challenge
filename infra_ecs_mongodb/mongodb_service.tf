module "mongodb-tech-challenge" {
  source = "../module/ecs-service"

  cluster                = aws_ecs_cluster.mongodb_cluster.id
  name                   = var.mongodb_cluster
  image                  = var.image
  containerPort          = var.containerPort
  create_lb              = var.nlb_enabled
  lb_arn                 = data.aws_lb.mongodb_lb.arn
  desired_count          = var.desired_count
  memory                 = var.memory
  discovery_namespace_id = "tech-challenge-ns"
  security_groups        = [aws_security_group.mongodb_sg.id]
  subnets                = tolist(data.aws_subnets.tech-challenge-subnet.ids)
  task_role_arn          = var.aws_iam_role
  execution_role_arn     = var.aws_iam_role
  environment = [
    { "name" : "MONGO_DATABASE", "value" : "tech-challenge" },
    { "name" : "MONGODB_ROOT_PASSWORD", "value" : "${var.mongo_password}" },
    { "name" : "MONGODB_ADVERTISED_HOSTNAME", "value" : "${var.mongodb_namespace}" },
    { "name" : "MONGO_INITDB_ROOT_USERNAME", "value" : "${var.mongo_user}" },
    { "name" : "MONGO_INITDB_ROOT_PASSWORD", "value" : "${var.mongo_password}" },
  ]
  volumes = [
    {
      "name" = "mongodb-data"
      "docker_volume_configuration" : {
        "scope" : "shared",
        "autoprovision" : true,
        "driver" : "local"
      }
    }
  ]
  mountPoints = [
    {
      "sourceVolume"  = "mongodb-data"
      "containerPath" = "/data/db"
    }
  ]
  placementConstraints = [
    {
      "type"       = "memberOf"
      "expression" = "attribute:ecs.availability-zone in [us-east-1a, us-east-1b, us-east-1c]"
    }
  ]
}
