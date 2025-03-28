// TERRAMATE: GENERATED AUTOMATICALLY DO NOT EDIT

terraform {
  required_version = ">= 1.9"
}
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 6.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = ">= 6.0"
    }
  }
}
provider "google" {
  project = "helmless"
  region  = "europe-west1"
  zone    = "europe-west1-d"
}
provider "google-beta" {
  project = "helmless"
  region  = "europe-west1"
  zone    = "europe-west1-d"
}
