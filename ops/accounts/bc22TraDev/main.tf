terraform {
  backend "s3" {
    bucket = "bc2022-remote-tfstate"
    key    = "dev/terraform.tfstate"
    region = "us-east-1"

    dynamodb_table = "terraform-dynamodb-locking"
    encrypt        = true
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
  source      = "../../resources/vpc"
  environment = var.environment

  bc22_vpc_cidr = "10.20.22.0/24"

  bc22_subnet_cidr = {
    "dbsn_a" = "10.20.22.64/26"
    "dbsn_b" = "10.20.22.192/26"
  }

  bc22_az = {
    "az_a" = "us-east-1a"
    "az_b" = "us-east-1b"
  }
}

module "database" {
  source = "../../resources/database"

  db_pass = var.db_pass
  db_user = var.db_user

  environment = var.environment

  subnetgroup = module.vpc.db_subnet_output
}
module "cloudtechcamp" {
  source = "../../resources/cloudtechcamp"
  environment = var.environment

  }


