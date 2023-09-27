terraform {
  backend "s3" {
    bucket = "llamba-2-terraform-state"
    key    = "state"
    region = "eu-west-2"
  }
}