terraform {
    backend "s3" {
        bucket = "bc2022-remote-tfstate"
        key = "dev/terraform.tfstate"
        region = "us-east-1"
    }
}


module "web" {
    source = "../../resources/web"
    environment = "dev"
}