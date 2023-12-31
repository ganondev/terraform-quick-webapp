resource "aws_cloudfront_distribution" "site_cloudfront" {

  enabled = true

  aliases = local.cloudfront_aliases

  default_cache_behavior {

    cache_policy_id  = "4135ea2d-6df8-44a3-9df3-4b5a84be39ad"
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = aws_s3_bucket.site_bucket.bucket_regional_domain_name

    compress = true

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0 // TODO
    default_ttl            = 0 // TODO
    max_ttl                = 0 // TODO
  }

  origin {
    connection_attempts = 3
    connection_timeout  = 10
    domain_name         = aws_s3_bucket.site_bucket.bucket_regional_domain_name
    origin_id           = aws_s3_bucket.site_bucket.bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.s3_access_control.id
  }

  is_ipv6_enabled     = true
  comment             = "UI for note.soy"
  default_root_object = "index.html"

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  price_class = "PriceClass_100"

  viewer_certificate {
    acm_certificate_arn            = aws_acm_certificate_validation.site_cert_validation.certificate_arn
    cloudfront_default_certificate = false
    minimum_protocol_version       = "TLSv1.2_2021"
    ssl_support_method             = "sni-only"
  }

  custom_error_response {
    error_caching_min_ttl = 0
    error_code            = 404
    response_code         = 404
    response_page_path    = "/index.html"
  }

  // TODO make optional
#  logging_config {
#    bucket = aws_s3_bucket.cloudfront_logging.bucket_domain_name
#  }

}

resource "aws_cloudfront_origin_access_control" "s3_access_control" {
  name                              = aws_s3_bucket.site_bucket.bucket_regional_domain_name
  description                       = "Quick webapp origin control"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}