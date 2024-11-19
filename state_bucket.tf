resource "google_storage_bucket" "state_bucket" {
  name = "helmless-state"
  location = "europe-west1"
}
