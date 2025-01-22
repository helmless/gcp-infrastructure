locals {
  # a list of repositories that are allowed to deploy to Google Cloud Run
  github_organization = "helmless"
  repositories = [
    "helmless",
    "google-cloudrun"
  ]
}

data "google_project" "project" {}

module "github_federation" {
  source              = "github.com/helmless/google-workload-identity-federation-terraform-module?ref=v0.1.0"
  id                  = "github"
  github_organization = local.github_organization
}

locals {
  repository_principals = { for repository in local.repositories : repository => "${module.github_federation.repository_principal_set_id_prefix}/${repository}" }
}

resource "google_project_iam_member" "run_admin" {
  for_each = local.repository_principals
  project  = data.google_project.project.project_id
  role     = "roles/run.admin"
  member   = each.value
}

resource "google_project_iam_member" "cloud_deploy" {
  for_each = local.repository_principals
  project  = data.google_project.project.project_id
  role     = "roles/clouddeploy.jobRunner"
  member   = each.value
}

resource "google_project_iam_member" "default_service_account_deploy_runner" {
  project = data.google_project.project.project_id
  role    = "roles/clouddeploy.jobRunner"
  member  = "serviceAccount:${data.google_project.project.number}-compute@developer.gserviceaccount.com"
}

resource "google_service_account_iam_member" "cloud_run_service_account_user" {
  for_each = local.repository_principals

  service_account_id = "projects/${data.google_project.project.project_id}/serviceAccounts/${data.google_project.project.number}-compute@developer.gserviceaccount.com"
  role               = "roles/iam.serviceAccountUser"
  member             = each.value
}
