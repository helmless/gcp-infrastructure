module "workload_identity" {
  source   = "github.com/helmless/google-workload-identity-federation-terraform-module//repository?ref=v0.2.0"

  repository = "helmless/google-cloudrun-example"
}

module "cloudrun_service_e2e_test" {
  source = "github.com/helmless/google-cloudrun-service-terraform-module?ref=v0.1.2"

  name   = "google-cloudrun-example"
  region = "europe-west1"

  deployment_accounts    = [module.workload_identity.principal_set]
  create_service_account = true

  deletion_protection = false
}
