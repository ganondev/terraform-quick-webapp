resource github_repository frontend_repository {

  name = local.frontend_repository_name
  lifecycle {
    ignore_changes = all
  }

  template {
    owner      = "ganondev"
    repository = "quick-webapp-template"
  }

}

resource github_actions_secret aws_access_key {
  repository  = github_repository.frontend_repository.name
  secret_name = "AWS_ACCESS_KEY"
  plaintext_value = aws_iam_access_key.s3_deploy_user_secrets.id
}

resource github_actions_secret aws_secret_key {
  repository  = github_repository.frontend_repository.name
  secret_name = "AWS_SECRET_KEY"
  plaintext_value = aws_iam_access_key.s3_deploy_user_secrets.secret
}