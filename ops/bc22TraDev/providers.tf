terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
        }
    }
}

provider "aws" {
    region = "us-east-1"
}

module "dir" {
  source  = "hashicorp/dir/template"
  version = "1.0.2"
  base_dir = "site_files/"
}