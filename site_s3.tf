resource aws_s3_bucket site_bucket {
  bucket = var.site_bucket_name
}

resource aws_s3_bucket_policy site_bucket_policy {
  bucket = aws_s3_bucket.site_bucket.id
  policy = data.aws_iam_policy_document.site_cloudfront_access_policy.json
}

data "aws_iam_policy_document" "site_cloudfront_access_policy" {
  policy_id = "PolicyForCloudFrontPrivateContent"
  version   = "2008-10-17"

  statement {

    sid = "AllowCloudFrontServicePrincipal"

    principals {
      identifiers = ["cloudfront.amazonaws.com"]
      type        = "Service"
    }

    effect = "Allow"

    actions = [
      "s3:GetObject",
      "s3:ListBucket",
    ]

    resources = [
      aws_s3_bucket.site_bucket.arn,
      "${aws_s3_bucket.site_bucket.arn}/*",
    ]

    condition {
      test     = "StringEquals"
      values   = [aws_cloudfront_distribution.site_cloudfront.arn]
      variable = "AWS:SourceArn"
    }
  }
}