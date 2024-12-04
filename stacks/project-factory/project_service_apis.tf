locals {
  service_apis = [
    "iam.googleapis.com",
    "run.googleapis.com"
  ]
}

data "google_project" "project" {}

resource "google_project_service" "project" {
  for_each = toset(local.service_apis)
  project  = data.google_project.project.project_id
  service  = each.value

  timeouts {
    create = "30m"
    update = "40m"
  }

  disable_on_destroy = false
}