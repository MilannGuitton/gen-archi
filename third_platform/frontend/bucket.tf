# --- Bucket Section --- #

# ----------------------------------------------------------------- Bucket --- #

resource "aws_s3_bucket" "website" {
  bucket        = "${var.website_prefix}${var.zone_name}"
  force_destroy = true

  tags = {
    Terraform = "true"
  }
}

resource "aws_s3_bucket_acl" "website_acl" {
  bucket = aws_s3_bucket.website.id
  acl    = "private"
}


# ----------------------------------------------------------------- Access --- #

resource "aws_s3_bucket_public_access_block" "website_access" {
  bucket = aws_s3_bucket.website.id

  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true
}

data "aws_iam_policy_document" "website_policy" {
  statement {
    sid       = "1"
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.website.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.origin_access_identity.iam_arn]
    }
  }
}

resource "aws_s3_bucket_policy" "website" {
  bucket = aws_s3_bucket.website.id
  policy = data.aws_iam_policy_document.website_policy.json
}
