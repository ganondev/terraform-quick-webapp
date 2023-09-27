variable "domain_name" {
  type = string
}

variable "route53_hosted_zone_id" {
  type = string
}

variable "acm_alternative_names" {
  type = list(string)
  default = []
}

variable "site_bucket_name" {
  type = string
  default = var.domain_name
}

variable cloudfront_aliases {
  type = list(string)
  default = [var.domain_name]
}