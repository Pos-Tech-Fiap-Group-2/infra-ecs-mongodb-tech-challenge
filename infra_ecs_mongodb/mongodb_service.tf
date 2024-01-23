resource "aws_ecs_service" "mongodb_service" {
  name            = var.mongodb_service
  cluster         = data.aws_ecs_cluster.ecs-mongo.id
  task_definition = aws_ecs_task_definition.mongodb_task.arn
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = data.aws_subnets.tech-challenge-subnet.ids
    security_groups = [aws_security_group.mongodb_sg.id]
  }

}

resource "aws_ecs_task_definition" "mongodb_task" {
  family                   = "mongodb-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.cpu
  memory                   = var.memory
  execution_role_arn       = var.aws_iam_role
container_definitions = jsonencode(
    [
      {
        "name": "mongodb-tech-challenge-producao",
        "image": "${var.image}",
        "create_lb": "${var.nlb_enabled}",
        "lb_arn": "${var.nlb_enabled ? aws_lb.mongodb_lb[0].arn : ""}",
        "desired_count": "${var.primary_enabled ? 1 : 0}",
        "portMappings": [
          {
            "containerPort": 27017,
            "hostPort": 27017,
            "listener_port": 27017
          }
        ],
        "volumes": [
          {
            "name": "mongodb-tech-challenge-producao",
            "dockerVolumeConfiguration": {
              "scope": "shared",
              "autoprovision": true,
              "driver": "local"
            },
            "host_path": "/data/mongodb"
          }
        ],
        "environment": [
          { "name" : "MONGO_DATABASE", "value" : "tech-challenge" },
          { "name" : "MONGODB_ROOT_PASSWORD", "value" : "${var.mongo_password}" },
          { "name" : "MONGODB_ADVERTISED_HOSTNAME", "value" : "${var.mongodb_namespace}" },
          { "name" : "MONGO_INITDB_ROOT_USERNAME", "value" : "${var.mongo_user}" },
          { "name" : "MONGO_INITDB_ROOT_PASSWORD", "value" : "${var.mongo_password}" },
          
        ]
      }
    ]
  )
}
