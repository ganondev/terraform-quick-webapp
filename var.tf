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
  default = null
}

variable cloudfront_aliases {
  type = list(string)
  default = null
}

locals {
  site_bucket_name = coalesce(var.site_bucket_name, var.domain_name)
  cloudfront_aliases = coalesce(var.cloudfront_aliases, [var.domain_name])
}