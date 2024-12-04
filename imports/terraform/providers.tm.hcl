globals "config" "terraform" "providers" "null" {
  enabled = false
  source  = "hashicorp/null"
  version = "~> 3.2"
}

globals "config" "terraform" "providers" "google" {
  enabled = true
  source  = "hashicorp/google"
  version = ">= 6.0"
  config = {
    project = global.config.project
    region  = global.config.region
    zone    = global.config.zone
  }
}

globals "config" "terraform" "providers" "google-beta" {
  enabled = true
  source  = "hashicorp/google-beta"
  version = global.config.terraform.providers.google.version
  config = {
    project = global.config.terraform.providers.google.config.project
    region  = global.config.terraform.providers.google.config.region
    zone    = global.config.terraform.providers.google.config.zone
  }
}

generate_hcl "_terramate_generated_providers.tf" {
  condition = tm_contains(terramate.stack.tags, "terraform")

  lets {
    required_providers = { for k, v in tm_try(global.config.terraform.providers, {}) :
      k => {
        source  = v.source
        version = v.version
      } if tm_try(v.enabled, true)
    }
    providers = { for k, v in tm_try(global.config.terraform.providers, {}) :
      k => v.config if tm_try(v.enabled, true) && tm_can(v.config)
    }
  }

  content {
    # terraform version constraints
    terraform {
      required_version = tm_try(global.config.terraform.version, ">= 1.9")
    }

    # Provider version constraints
    terraform {
      tm_dynamic "required_providers" {
        attributes = let.required_providers
      }
    }

    tm_dynamic "provider" {
      for_each   = let.providers
      labels     = [provider.key]
      attributes = provider.value
    }
  }
}