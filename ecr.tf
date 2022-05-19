resource "aws_ecr_repository" "shopping_car" {
  name                 = "shopping_car"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}