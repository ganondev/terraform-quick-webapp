resource aws_iam_user s3_deploy_user {

  name = "${var.domain_name}-github-s3-deploy"

}

data aws_iam_policy_document s3_deploy {
  statement {
    effect  = "Allow"
    actions = ["s3:PutObject"]
    resources = [
      aws_s3_bucket.site_bucket.arn,
      "${aws_s3_bucket.site_bucket.arn}/*"
    ]
  }
}

resource aws_iam_policy s3_deploy_user_policy {
  policy = data.aws_iam_policy_document.s3_deploy.json
}

resource "aws_iam_user_policy" "site_deployment_permissions" {
  name   = "${var.domain_name}-github-s3-deploy"
  user   = aws_iam_user.s3_deploy_user.name
  policy = data.aws_iam_policy_document.s3_deploy.json
}

resource aws_iam_access_key s3_deploy_user_secrets {
  user = aws_iam_user.s3_deploy_user.name
}