locals {
  deployment_accounts = [for repository in local.repositories : "${module.github_federation.repository_principal_set_id_prefix}/${repository}"]
}

# module "cloudrun_service_e2e_test" {
#   source                 = "github.com/helmless/google-cloudrun-service-terraform-module?ref=v0.1.0"
#   name                   = "minimal-service"
#   deployment_accounts    = local.deployment_accounts
#   region                 = "europe-west1"
#   create_service_account = true
#   deletion_protection    = false
# }
