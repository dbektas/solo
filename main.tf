module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "${var.vpc_name}"
  cidr = "${var.vpc_cidr}"

  azs             = ["${data.aws_availability_zones.available.names}"]
  private_subnets = "${var.vpc_private_subnets_cidr}"
  public_subnets  = "${var.vpc_public_subnets_cidr}"

  enable_nat_gateway = false
  enable_vpn_gateway = false

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}

module "vpc_west" {
  providers = {
    aws  = "aws.ireland"
  }
  source = "terraform-aws-modules/vpc/aws"

  name = "${var.vpc_name}"
  cidr = "${var.vpc_cidr}"

  azs             = ["${var.azs_west}"]
  private_subnets = "${var.vpc_private_subnets_cidr}"
  public_subnets  = "${var.vpc_public_subnets_cidr}"

  enable_nat_gateway = false
  enable_vpn_gateway = false

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}

/*
module "vpc_peering" {
  source           = "./vpcPeering"
}
*/

module "remoteStateS3" {
  source = "./remoteStateS3"
}
