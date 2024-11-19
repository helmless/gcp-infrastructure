module "github_federation" {
  source              = "github.com/helmless/google-workload-identity-federation-terraform-module?ref=v0.1.0"
  id                  = "github"
  github_organization = "helmless"
}

resource "google_project_iam_member" "project" {
  for_each = toset(local.repositories)
  project  = data.google_project.project.project_id
  role     = "roles/run.admin"
  member   = "${module.github_federation.repository_principal_set_id_prefix}/${each.value}"
}
