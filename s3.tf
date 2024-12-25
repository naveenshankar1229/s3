resource "aws_s3_bucket" "nav" {
  bucket = var.bucket
  tags = {
    Name = "nav-bucket"
  }
}

resource "aws_s3_bucket_public_access_block" "navaccess" {
  bucket = aws_s3_bucket.nav.id
  block_public_acls = false
  block_public_policy = false
  ignore_public_acls = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "navpolicy" {
  bucket = aws_s3_bucket.nav.id
  policy = jsonencode({
  "Id": "Policy1735014267118",
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "PublicReadGetObject",
      "Action": [
        "s3:GetObject",
        "s3:GetObjectVersion"
      ],
      "Effect": "Allow",
      "Resource": "${aws_s3_bucket.nav.arn}/*",
      "Principal": "*"
    }
  ]
  
    
  })
}

resource "aws_s3_object" "objects" {
  bucket = aws_s3_bucket.nav.id
  key = "Seattle.jpg"
  source = var.object_path
  content_type = "image/jpeg"

}