resource "aws_iam_role" "ecs_task_execution_role" {
  name = "${var.layer}-${var.stack_id}-ecs-task-execution-role"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Principal": {
          "Service": "ecs-tasks.amazonaws.com"
        },
        "Effect": "Allow"
      }
    ]
}
EOF
}

resource "aws_iam_role" "task_role_arn" {
  name = "${var.layer}-${var.stack_id}-taskecs-fargate"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
            "Service": [
                "s3.amazonaws.com",
                "lambda.amazonaws.com",
                "ecs.amazonaws.com",
                "batch.amazonaws.com",
                "ecs-tasks.amazonaws.com"
            ]
            },
            "Effect": "Allow"
        }
    ]
}
EOF
}