module "github_federation" {
  source              = "github.com/helmless/google-workload-identity-federation-terraform-module?ref=v0.1.0"
  id                  = "github"
  github_organization = "helmless"
}

locals {
  repository_principals = { for repository in local.repositories : repository => "${module.github_federation.repository_principal_set_id_prefix}/${repository}" }
}

resource "google_project_iam_member" "project" {
  for_each = local.repository_principals
  project  = data.google_project.project.project_id
  role     = "roles/run.admin"
  member   = each.value
}

resource "google_service_account_iam_member" "cloud_run_v2" {
  for_each = local.repository_principals

  service_account_id = "projects/${data.google_project.project.project_id}/serviceAccounts/${data.google_project.project.number}-compute@developer.gserviceaccount.com"
  role               = "roles/iam.serviceAccountUser"
  member             = each.value
}
