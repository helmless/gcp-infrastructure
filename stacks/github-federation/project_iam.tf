locals {
  repositories = [
    "helmless",
    "google-cloudrun-action",
    "google-cloudrun-charts"
  ]
}

data "google_project" "project" {}

module "principal_set" {
  for_each = toset(local.repositories)
  source   = "github.com/helmless/google-workload-identity-federation-terraform-module//repository?ref=v0.2.0"

  repository = "${local.github_organization}/${each.key}" # (1)
}

resource "google_project_iam_member" "run_admin" {
  for_each = toset(local.repositories)
  project  = data.google_project.project.project_id
  role     = "roles/run.admin"
  member   = module.principal_set[each.key].principal_set # (2)
}

resource "google_service_account_iam_member" "cloud_run_service_account_user" {
  for_each = toset(local.repositories)

  service_account_id = "projects/${data.google_project.project.project_id}/serviceAccounts/${data.google_project.project.number}-compute@developer.gserviceaccount.com" # (3)
  role               = "roles/iam.serviceAccountUser"
  member             = module.principal_set[each.key].principal_set # (4)
}
