terraform {
  backend "s3" {
    bucket = "llamba-terraform-state"
    key    = "eu-west-1"
    region = "eu-west-1"
  }
}