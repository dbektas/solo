terraform {
  backend "s3" {
    bucket = "tfstate-566921358159"
    key    = "solo.tfstate"
    region = "eu-central-1"
  }
}
