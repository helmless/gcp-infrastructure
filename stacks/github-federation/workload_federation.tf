locals {
  # a list of repositories that are allowed to deploy to Google Cloud Run
  github_organization = "helmless"
}

module "github_federation" {
  source              = "github.com/helmless/google-workload-identity-federation-terraform-module?ref=v0.1.0"
  id                  = "github"
  github_organization = local.github_organization
}
