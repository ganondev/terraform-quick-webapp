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