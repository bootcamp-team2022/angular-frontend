terraform {
  backend "s3" {
    bucket = "bc2022-remote-tfstate"
    key    = "dev/terraform.tfstate"
    region = "us-east-1"
  }
}


module "web" {
  source      = "../../resources/web"
  environment = var.environment
}

module "instances" {
  source      = "../../resources/instances"
  volume_size = var.volume_size
}

module "vpc" {
    source = "../../resources/vpc"
    environment = var.environment

    bc22_vpc_cidr = "10.20.22.0/24"

    bc22_subnet_cidr = {
        "dbsn1" = "10.20.22.64/26"
        "dbsn2" = "10.20.22.192/26"
    }
	
    bc22_az = {
        "az_a" = "us-east-1a"
        "az_b" = "us-east-1b"
    }
}