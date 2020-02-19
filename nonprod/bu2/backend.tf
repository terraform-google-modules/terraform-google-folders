terraform {
  backend "gcs" {
    bucket = "your bucket here"
    prefix = "state/folders/nonprod/bu2"
  }
}