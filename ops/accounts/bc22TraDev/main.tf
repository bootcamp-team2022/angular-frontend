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
name: Fix terraform file formatting

on:
  push:
    branches:
      - main

jobs:
  format:
    runs-on: ubuntu-latest
    name: Check terraform file are formatted correctly
    steps:
      - name: Checkout
        uses: actions/checkout@v2

      - name: terraform fmt
        uses: dflook/terraform-fmt@v1
        with:
          path: my-terraform-config

      - name: Create Pull Request
        uses: peter-evans/create-pull-request@v2
        with:
          commit-message: terraform fmt
          title: Reformat terraform files
          body: Update terraform files to canonical format using `terraform fmt`
          branch: automated-terraform-fmt

on: [push]

jobs:
  validate:
    runs-on: ubuntu-latest
    name: Validate terraform
    steps:
      - name: Checkout
        uses: actions/checkout@v2

      - name: terraform validate
        uses: dflook/terraform-validate@v1
        with:
          path: my-terraform-config
on: [push]

jobs:
  validate:
    runs-on: ubuntu-latest
    name: Validate terraform
    steps:
      - name: Checkout
        uses: actions/checkout@v2

      - name: terraform validate
        uses: dflook/terraform-validate@v1
        id: validate
        with:
          path: my-terraform-config

      - name: Validate failed
        if: ${{ failure() && steps.validate.outputs.failure-reason == 'validate-failed' }}
        run: echo "terraform validate failed"
name: Terraform Plan

on: [issue_comment]

jobs:
  plan:
    if: ${{ github.event.issue.pull_request && contains(github.event.comment.body, 'terraform plan') }}
    runs-on: ubuntu-latest
    name: Create terraform plan
    env:
      GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
    steps:
      - name: Checkout
        uses: actions/checkout@v2
        with:
          ref: refs/pull/${{ github.event.issue.number }}/merge

      - name: terraform plan
        uses: dflook/terraform-plan@v1
        with:
          path: my-terraform-config