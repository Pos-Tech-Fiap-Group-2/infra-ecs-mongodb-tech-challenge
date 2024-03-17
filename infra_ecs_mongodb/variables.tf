
variable "aws_region" {
  default = "us-east-1"
}

variable "mongodb_service" {
  default = "mongodb-tech-challenge-service"
}

variable "mongodb_cluster" {
  description = "ECS Cluster"
  type        = string
  default     = "mongodb-cluster"

}

variable "lb_name" {
  default = "tech-challenge-lb"
}
variable "lb_arn" {
  default = "arn:aws:elasticloadbalancing:us-east-1:654654392738:loadbalancer/app/tech-challenge-lb/8a02b301ed6f1d81"
}

variable "mongodb_sg" {
  default = "mongodb_sg"
}

variable "ingress_cidr_blocks" {
  description = "Allow traffic from Cidr blocks, override for internal Cidr blocks"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "nlb_enabled" {
  description = "Enable NLB"
  type        = bool
  default     = false
}

variable "mongo-ecs-execution-role" {
  default = "mongo-ecs-execution-role"
}

variable "desired_count" {
  default = 1
}

variable "ecs_user_password" {
  description = "ECS User"
  type        = string
  default     = "admin"
}

variable "mongo_password" {
  description = "Mongo db password"
  type        = string
  default     = "admin"
}

variable "mongo_user" {
  description = "Mongo db user"
  type        = string
  default     = "admin"

}

variable "memory" {
  description = "Fargate Memory"
  type        = number
  default     = 1024
}

variable "cpu" {
  description = "Fargate CPU"
  type        = number
  default     = 512
}

variable "mongodb_namespace" {
  description = "Mongo Namespace"
  type        = string
  default     = "mongodb-tech-challenge-producao"

}

variable "ami_restore" {
  description = "AMI Restore"
  type        = string
  default     = null

}

variable "instance_type" {
  description = "Instance Type"
  type        = string
  default     = "m5.large"
}

variable "volume_type" {
  description = "Volume Type"
  type        = string
  default     = "gp2"

}

variable "volume_size" {
  description = "Volume Size"
  type        = number
  default     = 30

}

variable "mongodb_profile_instance" {
  description = "Mongo Profile Instance"
  type        = string
  default     = "mongodb-profile-instance"
}

variable "mongodb_role_policy" {
  description = "Mongo Role Policy"
  type        = string
  default     = "mongodb-role-policy"
}

variable "mongodb_role" {
  description = "Mongo Role"
  type        = string
  default     = "mongodb-role"

}

variable "image" {
  type    = string
  default = "mongo:latest"
}

variable "primary_enabled" {
  description = "Enable primary node, min setup"
  type        = bool
  default     = true
}

variable "aws_iam_role" {
  description = "AWS IAM Role"
  type        = string
  default     = "arn:aws:iam::654654392738:role/LabRole"

}

variable "aws_instance_profile" {
  description = "AWS Instance Profile"
  type        = string
  default     = "LabInstanceProfile"

}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
  default     = "vpc-0a47e4de920d31a8d"

}

variable "containerPort" {
  description = "Container Port"
  type        = number
  default     = 27017

}

variable "target_group_arn" {
  description = "Target Group ARN"
  type        = string
  default     = "arn:aws:elasticloadbalancing:us-east-1:654654392738:targetgroup/tech-challenge-lb-tg/0202c3b632c26b2d"
}

variable "target_group_name" {
  description = "Target Group Name"
  type        = string
  default     = "tech-challenge-lb-tg"

}
