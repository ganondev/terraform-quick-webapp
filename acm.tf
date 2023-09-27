resource "aws_acm_certificate" "site_cert_request" {
  domain_name               = "note.soy"
  subject_alternative_names = ["*.note.soy"]
  validation_method         = "DNS"
}

resource "aws_acm_certificate_validation" "site_cert_validation" {
  certificate_arn         = aws_acm_certificate.site_cert_request.arn
  validation_record_fqdns = [for record in aws_route53_record.site_acm_verification_record : record.fqdn]
}