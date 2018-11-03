terraform {
  backend "s3" {
    bucket = "tfstate-341697886451"
    key    = "solo.tfstate"
    region = "eu-central-1"
  }
}
