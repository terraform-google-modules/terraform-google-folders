terraform {
  backend "gcs" {
    bucket = "your bucket here"
    prefix = "state/folders/prod/bu1/prod"
  }
}