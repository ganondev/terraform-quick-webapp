resource "aws_route53_record" "site_acm_verification_record" {
  for_each = {
    for dvo in aws_acm_certificate.site_cert_request.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 300
  type            = each.value.type
  zone_id         = var.route53_hosted_zone_id
}

resource "aws_route53_record" "site_cloudfront_ip4_record" {

  name    = var.domain_name
  type    = "A"
  zone_id = var.route53_hosted_zone_id

  alias {
    evaluate_target_health = true
    name                   = aws_cloudfront_distribution.site_cloudfront.domain_name
    zone_id                = "Z2FDTNDATAQYW2"
  }
}

resource "aws_route53_record" "site_cloudfront_ip6_record" {

  name    = var.domain_name
  type    = "AAAA"
  zone_id = var.route53_hosted_zone_id

  alias {
    evaluate_target_health = true
    name                   = aws_cloudfront_distribution.site_cloudfront.domain_name
    zone_id                = "Z2FDTNDATAQYW2"
  }
}