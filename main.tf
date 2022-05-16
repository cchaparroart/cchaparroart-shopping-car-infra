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
    organization = "CONDOR"

    workspaces {
      name = "gh-demo-shopping"
    }
  }
}