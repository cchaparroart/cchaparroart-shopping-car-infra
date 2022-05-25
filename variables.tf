variable "layer" {
  description = "Nombre del proyecto"
  type        = string
}

variable "stack_id" {
  description = "Nombre del ambiente"
  type        = string
}

variable "app_port" {
  default = "80"
}


variable "fargate_cpu" {
  default = "256"
}

variable "fargate_memory" {
  default = "512"
}

variable "task_definition_shopping_car" {
  default = "shopping-car-tsk"
}

variable "region" {
  type        = string
  default     = "us-east-1"
  description = "AWS Region"
}

variable "service_shopping_car" {
  default = "node-shopping-car"
}

variable "aws_alb_default_listener" {
  type        = string
  description = "Default 443 ARN Listener"
}

variable "aws_vpc" {
  type        = string
  description = "Vpc"
}

variable "cluster_node_name" {
  default = "ms-node-fargate"
}

variable "app_count" {
  default = "2"
}
variable "aws_security_group" {
  type        = string
  description = "Security group"
}
variable "aws_subnet" {
  type        = string
  description = "Subnets"
}