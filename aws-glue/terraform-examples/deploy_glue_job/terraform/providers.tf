terraform {
  required_version = "~> 1.8.5"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.54.0"  
    } 
    }
  }

  provider "aws" {
    region = "us-east-2" 
    profile = "default"
}

terraform {
  backend "s3" {
    bucket = "<+++++++++++++>" # bucket name from s3
    key    = "terraform/terraform.tfstate"
    region = "us-east-2"
    profile = "default"
  }
}