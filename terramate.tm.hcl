terramate {
  required_version                   = ">= 0.11.0"
  required_version_allow_prereleases = true

  config {
    experiments = [
      "tmgen"
    ]
  }
}

import {
  source = "/imports/defaults.tm.hcl"
}