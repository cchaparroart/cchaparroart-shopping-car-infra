resource "aws_ecr_repository" "image_shopping_car" {
  name                 = "${var.layer}-${var.stack_id}-ecr"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

