terraform {
    backend "s3" {
        bucket = "bc2022-remote-tfstate"
        key = "state/terraform.tfstate"
        region = "us-east-1"
    }
}

data "aws_s3_bucket" "tf-state-bucket" {
    bucket = "bc2022-remote-tfstate"
}

resource "aws_s3_bucket_acl" "tf-state-bucketacl" {
    bucket = data.aws_s3_bucket.tf-state-bucket.id
    acl = "private"
}


resource "aws_s3_bucket_public_access_block" "remotestate-bucket-block" {
    bucket = data.aws_s3_bucket.tf-state-bucket.id

    block_public_acls = true
    block_public_policy = true
    ignore_public_acls = true
    restrict_public_buckets = true
    
}