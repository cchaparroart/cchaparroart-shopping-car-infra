resource "aws_cloudwatch_log_group" "cloudwatch_shopping_car" {
  name = "${var.layer}-${var.stack_id}-${var.task_definition_shopping_car}-log"

  tags = {
    Environment = "${var.stack_id}"
  }
}