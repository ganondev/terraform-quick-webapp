# Quick Webapp

I found myself going through the process of standing up Route53->CloudFront->S3
infrastructure for serverless static websites repeatedly, and every time struggling
because I forgot some nuance in the stack such that once I go to test a request
it inevitably fails, be it with a permission issue at the S3 origin layer or some
DNS misconfiguration. This module sets all that annoying stuff in stone, because this
certainly won't be the last time I do this.

## What does this get you?

* ### DNS
  * IPv4 and IPv6 alias records to CloudFront within Route53
  * ACM certificate with validation records in Route53
* ### CDN
  * CloudFront distribution preconfigured with reasonable (?) defaults
    * (If you need a parameter exposed submit an issue or put up a PR)
  * S3 origin configured for access via origin access control
* ### S3
  * An S3 bucket
  * A deployment IAM user with PutObject permissions
  * Not a lot to it
* ### Github
  * A repository preconfigured with access keys secrets for the S3 deploy user
  * Template for s3 deployment on merge to `main`
  * **Note:** the repository will be added to whatever organization is associated with the authentication for your `github` provider 

## Prerequisites needed:
* A Route53 hosted zone in the desired AWS account with the desired domain name
  * The actual DNS registrar doesn't matter
* A terraform IAM user (or otherwise some identity to assume when applying) with the appropriate grants:
  * CloudFront + CloudFront Origin Access Control
  * S3 + Bucket policies
  * Route53 hosted zones + records
  * ACM requests
  * Creating IAM policies (for S3)
  * Creating IAM users (for S3 deploy user)
  * Generating access keys (for S3 deploy user)
  * **Please let me know if I missed anything**

## Future:
* Optionally preconfiguring an IAM user with necessary permissions, somehow
* Infrastructure for an API Gateway + Lambda backend