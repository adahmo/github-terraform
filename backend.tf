
terraform {
  backend "s3" {
    bucket         = "my-tf-adamumj-bucket-0477"
    region         = "us-east-1"
    key            = "s3-github-actions/terraform.tfstate"
    encrypt = true
  }
}


 
terraform {
required_version = ">=0.13.0"
  required_providers {
    aws = {
      version = ">= 2.7.0"
      source = "hashicorp/aws"
    }
  }
}

