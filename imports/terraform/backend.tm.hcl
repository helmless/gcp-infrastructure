generate_hcl "_terramate_generated_backend.tf" {
  condition = tm_contains(terramate.stack.tags, "terraform")

  content {
    terraform {
      backend "gcs" {
        bucket = global.config.state_bucket.name
        prefix = "/terramate/stacks/by-id/${terramate.stack.id}"
      }
    }
  }
}