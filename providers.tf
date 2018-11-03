provider "aws" {
  region = "${var.region}"
}

provider "aws" {
  alias = "ireland"
  region = "${var.region_west}"
}
