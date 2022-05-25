resource "aws_ecs_cluster" "main" {
  name = "${var.layer}-${var.stack_id}-fargate"
}

resource "aws_ecs_task_definition" "task_shopping_car" {
  family                   = "${var.layer}-${var.stack_id}-${var.task_definition_shopping_car}"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.fargate_cpu
  memory                   = var.fargate_memory
  task_role_arn            = aws_iam_role.task_role_arn.arn
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  container_definitions    = <<DEFINITION
[
  {
    "cpu": ${var.fargate_cpu},
    "image": "${aws_ecr_repository.image_shopping_car.repository_url}",
    "memory": ${var.fargate_memory},
    "name": "${var.layer}-${var.stack_id}-${var.task_definition_shopping_car}",
    "networkMode": "awsvpc",
    "secrets": [       
    ],
    "portMappings": [
      {
        "containerPort": ${var.app_port},
        "hostPort": ${var.app_port}
      }
    ],
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "${var.layer}-${var.stack_id}-${var.task_definition_shopping_car}-log",
        "awslogs-region": "${var.region}",
        "awslogs-stream-prefix": "ecs"
      }
    }
  }
]
DEFINITION
}

resource "aws_alb_target_group" "target_group_shopping_car" {
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.aws_vpc
  target_type = "ip"

  health_check {
    path                = "/documentos/actuator/health"
    port                = "traffic-port"
    healthy_threshold   = 2
    unhealthy_threshold = 5
    timeout             = 60
    interval            = 120
    matcher             = "200" # has to be HTTP 200 or fails
  }

  tags = {
    Name        = "${var.layer}-${var.stack_id}-${var.service_shopping_car}"
    Environment = var.stack_id
  }
}

resource "aws_alb_listener_rule" "listener_rule_shopping_car" {
  listener_arn = var.aws_alb_default_listener
  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.target_group_shopping_car.arn
  }
  condition {
    path_pattern {
      values = ["/documentos/*"]
    }
  }
}

resource "aws_ecs_service" "shopping_car" {
  name            = "${var.layer}-${var.stack_id}-${var.service_shopping_car}"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.task_shopping_car.arn
  desired_count   = var.app_count
  launch_type     = "FARGATE"

  network_configuration {
    security_groups = [var.aws_security_group]
    subnets         = split(",", var.aws_subnet)
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.target_group_shopping_car.id
    container_name   = "${var.layer}-${var.stack_id}-${var.task_definition_shopping_car}"
    container_port   = var.app_port
  }

  lifecycle {
    ignore_changes = [desired_count]
  }
}

resource "aws_appautoscaling_target" "ecs_target_shopping_car" {
  max_capacity       = 10
  min_capacity       = 2
  resource_id        = "service/${var.layer}-${var.stack_id}-${var.cluster_node_name}/${var.layer}-${var.stack_id}-${var.service_shopping_car}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

resource "aws_appautoscaling_policy" "ecs_policy_shopping_car" {
  name               = "scale-down"
  policy_type        = "StepScaling"
  resource_id        = aws_appautoscaling_target.ecs_target_shopping_car.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_target_shopping_car.scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs_target_shopping_car.service_namespace

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 60
    metric_aggregation_type = "Maximum"

    step_adjustment {
      metric_interval_upper_bound = 0
      scaling_adjustment          = -1
    }
  }
}
