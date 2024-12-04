locals {
  # a list of repositories that are allowed to deploy to Google Cloud Run
  github_organization = "helmless"
  repositories = [
    "helmless"
  ]
  service_apis = [
    "iam.googleapis.com",
    "run.googleapis.com"
  ]
}

data "google_project" "project" {}
