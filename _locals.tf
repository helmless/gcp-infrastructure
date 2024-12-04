locals {
  # a list of repositories that are allowed to deploy to Google Cloud Run
  repositories = [
    "helmless"
  ]
  service_apis = [
    "iam.googleapis.com",
    "run.googleapis.com"
  ]
}

data "google_project" "project" {}
