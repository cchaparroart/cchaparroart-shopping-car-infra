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
    token = "TzINXpdPu0yyDg.atlasv1.y8zkPTYsZkATmxj5f33SkM25cpz56Cn1JZRFXYFK9UgsLyDbwqWRVAMCk7dkS0XhYdc"
    workspaces {
      name = "gh-demo-shopping"
    }
  }
}

