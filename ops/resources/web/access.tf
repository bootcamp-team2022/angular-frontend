resource "aws_s3_bucket_acl" "tf-state-bucketacl" {
  bucket = data.aws_s3_bucket.tf-state-bucket.id
  acl    = "private"
}


resource "aws_s3_bucket_public_access_block" "remotestate-bucket-block" {
  bucket = data.aws_s3_bucket.tf-state-bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

}