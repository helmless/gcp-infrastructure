locals {
  github_organization = "helmless"
  repositories = [
    "helmless",
    "google-cloudrun-action",
    "google-cloudrun-charts"
  ]
}

module "workload_identity" {
  for_each = toset(local.repositories)
  source   = "github.com/helmless/google-workload-identity-federation-terraform-module//repository?ref=v0.2.0"

  repository = "${local.github_organization}/${each.key}" # (1)
}

module "cloudrun_service_e2e_test" {
  source = "github.com/helmless/google-cloudrun-service-terraform-module?ref=v0.1.2"

  name   = "full-service" # (2)
  region = "europe-west1"

  deployment_accounts    = values(module.workload_identity).*.principal_set # (3)
  create_service_account = true # (4)

  deletion_protection = false
}
