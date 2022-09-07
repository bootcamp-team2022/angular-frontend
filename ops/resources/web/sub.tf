resource "aws_s3_bucket" "sub_web_enabled_bucket" {
  bucket = "www.${var.environment}.cloudtechcamp.com"

  tags = {
    Environment = var.environment
    description = "Test bucket"
  }

}

resource "aws_s3_bucket_acl" "sub_web_enabled_bucket_acl" {
  bucket = "www.${aws_s3_bucket.web_enabled_bucket.id}"
  acl    = "public-read"
}

resource "aws_s3_bucket_website_configuration" "sub_web_enabled_bucket_config" {
  bucket = "www.${aws_s3_bucket.web_enabled_bucket.id}"

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "index.html"
  }

  depends_on = [
    aws_s3_bucket_policy.web_bucket_anon_policy
  ]
}

resource "aws_s3_bucket_policy" "sub_web_bucket_anon_policy" {
  bucket = "www.${aws_s3_bucket.web_enabled_bucket.id}"

  policy = <<EOF
    {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": [
                "s3:GetObject"
            ],
            "Resource": [
                "${aws_s3_bucket.sub_web_enabled_bucket.arn}/*",
                "${aws_s3_bucket.sub_web_enabled_bucket.arn}"
            ]
        }
    ]
}
    EOF
}



