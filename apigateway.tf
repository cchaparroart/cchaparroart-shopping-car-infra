resource "aws_api_gateway_rest_api" "api_gateway_core" {
  name = "${var.layer}-${var.stack_id}-api-gateway"
  description = "descripcion api gateway"
  endpoint_configuration {
    types = ["REGIONAL"]
  }
}