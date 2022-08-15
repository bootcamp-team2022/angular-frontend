resource "aws_s3_bucket" "web_enabled_bucket" {
    bucket = "bootcamp-${var.environment}.com"

    tags = {
        Environment = var.environment
        description = "Test bucket"
    }

}

 resource "aws_s3_bucket_acl" "web_enabled_bucket_acl" {
    bucket = aws_s3_bucket.web_enabled_bucket.id
    acl = "public-read"
}

resource "aws_s3_bucket_website_configuration" "web_enabled_bucket_config" {
    bucket = aws_s3_bucket.web_enabled_bucket.id
    
    index_document {
        suffix = "index.html"    
    }

    error_document {
        key = "error.html"
    }

    depends_on = [
      aws_s3_bucket_policy.web_bucket_anon_policy
    ]
}

resource "aws_s3_bucket_policy" "web_bucket_anon_policy" {
    bucket = aws_s3_bucket.web_enabled_bucket.id

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
                "${aws_s3_bucket.web_enabled_bucket.arn}/*",
                "${aws_s3_bucket.web_enabled_bucket.arn}"
            ]
        }
    ]
}
    EOF
}



