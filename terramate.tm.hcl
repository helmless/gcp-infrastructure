import {
  source = "/imports/defaults.tm.hcl"
}

terramate {
  required_version                   = ">= 0.11.0"
  required_version_allow_prereleases = true

  config {
    experiments = [
      "tmgen",
      "scripts"
    ]
  }
}

script "plan" {
  description = "Run a Terraform plan"
  lets {
    provisioner = "terraform" # another option: "tofu"
  }
  job {
    name        = "plan"
    description = "Initialize, validate and plan Terraform stacks"
    commands = [
      [let.provisioner, "init"],
      [let.provisioner, "validate"],
      [let.provisioner, "plan"],
    ]
  }
}

script "apply" {
  description = "Run a Terraform deployment"
  lets {
    provisioner = "terraform" # another option: "tofu"
  }
  job {
    name        = "apply"
    description = "Initialize, validate and deploy Terraform stacks"
    commands = [
      [let.provisioner, "init"],
      [let.provisioner, "validate"],
      ["trivy", "config", "."],
      [let.provisioner, "apply"],
    ]
  }
}