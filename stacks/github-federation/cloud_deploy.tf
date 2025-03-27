resource "google_project_iam_member" "cloud_deploy" {
  for_each = toset(local.repositories)
  project  = data.google_project.project.project_id
  role     = "roles/clouddeploy.jobRunner"
  member   = module.principal_set[each.key].principal_set
}

resource "google_project_iam_member" "default_service_account_deploy_runner" {
  project = data.google_project.project.project_id
  role    = "roles/clouddeploy.jobRunner"
  member  = "serviceAccount:${data.google_project.project.number}-compute@developer.gserviceaccount.com"
}