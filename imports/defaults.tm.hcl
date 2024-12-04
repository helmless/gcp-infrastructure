globals "config" {
  project = "helmless"
  region  = "europe-west1"
  zone    = "europe-west1-d"

  state_bucket = {
    name     = "${global.config.project}-state"
    location = global.config.region
  }
}

import {
  source = "terraform/backend.tm.hcl"
}

import {
  source = "terraform/providers.tm.hcl"
}