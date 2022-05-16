terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
    random = {
      source = "hashicorp/random"
    }
  }
  provider "aws" {
    version = "~>3.0"
    region  = "east-us-1"
  }
  
  cloud {
    organization = "cchaparro"

    workspaces {
      name = "gh-demo-shopping"
    }
  }
}
