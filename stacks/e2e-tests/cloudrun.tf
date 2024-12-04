locals {
  repositories = [
      "helmless"
  ]
  deployment_accounts = [for repository in local.repositories : module.workload_identity[repository].principal_set]
}

module "workload_identity" {
  for_each = toset(local.repositories)
  source = "github.com/helmless/google-workload-identity-federation-terraform-module//repository?ref=v0.2.0"

  repository = "helmless/${each.key}"
}

module "cloudrun_service_e2e_test" {
  source                 = "github.com/helmless/google-cloudrun-service-terraform-module?ref=v0.1.1"
  name                   = "full-service"
  deployment_accounts    = local.deployment_accounts
  region                 = "europe-west1"
  create_service_account = true
  deletion_protection    = false
}
