variable "AWS_SECRET_ACCESS_KEY" {} 
variable "AWS_ACCESS_KEY_ID" {} 
variable "aws_region" {}
variable "app_prefix" {}
variable "stage_name" {
  default = "dev"
  type    = "string"
}