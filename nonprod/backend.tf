terraform {
  backend "gcs" {
    bucket = "konradlabs-terraform-state"
    prefix = "state/folders/nonprod"
  }
}