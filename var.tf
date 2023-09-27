variable "domain_name" {
  type = string
  description = "The domain name your webapp will live at. Required for Route53 aliases, as well as the ACM request."
}

variable "route53_hosted_zone_id" {
  type = string
  description = "ID for the Route53 hosted zone that created records will be added to"
}

variable "acm_alternative_names" {
  type = list(string)
  default = []
  description = "Alternative domain names that the ACM certificate should manage, if any."
}

variable "site_bucket_name" {
  type = string
  default = null
  description = "Name of the S3 bucket origin for site content. Will use domain_name by default."
}

variable cloudfront_aliases {
  type = list(string)
  default = null
  description = "Any aliases for the cloudfront distribution. By default this just be an array containing domain_name."
}

locals {
  site_bucket_name = coalesce(var.site_bucket_name, var.domain_name)
  cloudfront_aliases = coalesce(var.cloudfront_aliases, [var.domain_name])
}