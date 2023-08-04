resource "aws_cloudwatch_log_group" "ecs_vault" {
  name = "ecs/vault"

  retention_in_days = var.ecs_logs_retention_days

  tags = {
    Name = "vault"
  }
}


#---------------------------
# ECS Cluster
#---------------------------
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_cluster
resource "aws_ecs_cluster" "ecs_cluster" {
  name = var.ecs_cluster_name
}

resource "aws_ecs_cluster_capacity_providers" "ecs_cluster_capacity" {
  cluster_name = aws_ecs_cluster.ecs_cluster.name

  capacity_providers = ["FARGATE"]

  default_capacity_provider_strategy {
    base              = 1
    weight            = 100
    capacity_provider = "FARGATE"
  }
}


#---------------------------
# ECS Task Definition
#---------------------------
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition
resource "aws_ecs_task_definition" "ecs-task-def" {
  family                   = "vault-ecs-task-def"
  execution_role_arn       = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/ecsTaskExecutionRole"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 512
  memory                   = 1024
  container_definitions    = <<TASK_DEFINITION
[
  {
    "name": "vault-docker",
    "image": "hashicorp/vault:1.14",
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "${aws_cloudwatch_log_group.ecs_vault.id}",
        "awslogs-region": "${var.aws_region}",
        "awslogs-stream-prefix": "${var.ecs_service_name}"
      }
    },
    "portMappings": [
      {
        "hostPort": 8200,
        "protocol": "tcp",
        "containerPort": 8200
      }
    ],
    "environment": [
      {
        "name": "AWS_ACCESS_KEY_ID",
        "value": "${aws_iam_access_key.vault-user.id}"
      },
      {
        "name": "AWS_REGION",
        "value": "${var.aws_region}"
      },
      {
        "name": "AWS_S3_BUCKET",
        "value": "${aws_s3_bucket.vault_s3_backend.id}"
      },
      {
        "name": "AWS_SECRET_ACCESS_KEY",
        "value": "${aws_iam_access_key.vault-user.secret}"
      },
      {
        "name": "VAULT_AWSKMS_SEAL_KEY_ID",
        "value": "${aws_kms_key.vault_key.key_id}"
      }
    ],
    "essential": true
  }
]
TASK_DEFINITION

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }
}


# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service
resource "aws_ecs_service" "vault-svc" {
  name            = var.ecs_service_name
  cluster         = var.ecs_cluster_name
  task_definition = aws_ecs_task_definition.ecs-task-def.arn
  desired_count   = 1
  launch_type     = "FARGATE"
  network_configuration {
    subnets = module.vpc.public_subnets
    security_groups = [
      aws_security_group.vault.id
    ]
    assign_public_ip = "true"
  }
}