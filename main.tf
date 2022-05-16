terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      
    }
    random = {
      source = "hashicorp/random"
    }
  }

  cloud {
    organization = "cchaparro"

    workspaces {
      name = "gh-demo-shopping"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}