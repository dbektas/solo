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
  cidr = "${var.vpc_cidr_west}"

  azs             = ["${var.region_west}a", "${var.region_west}b", "${var.region_west}c"]
  private_subnets = "${var.vpc_private_subnets_cidr_west}"
  public_subnets  = "${var.vpc_public_subnets_cidr_west}"

  enable_nat_gateway = false
  enable_vpn_gateway = false

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}

module "bastion" {
  source = "./bastionHost"

  instance_type = "t2.micro"
  subnet_ids = ["${module.vpc.public_subnets}"]
  security_group_ids = ["${aws_security_group.bastion.id}"]
  public_ssh_key  = "${var.public_ssh_key}"
  desired_capacity = 1
  max_size = 1
  min_size = 1
  cooldown = 60
  health_check_grace_period = 300

  scale_up_cron = "0 9 * * *"
  scale_up_min_size = 1
  scale_up_max_size = 3
  scale_up_desired_capacity = 2

  scale_down_cron = "0 23 * * *"
  scale_down_min_size = 1
  scale_down_max_size = 1
  scale_down_desired_capacity = 1

  #enable_autoscaling = true
}

resource "aws_security_group" "bastion" {
  name = "bastion"
  description = "Security group used by the ec2 bastion host"
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = "${module.vpc.vpc_id}"
}

module "remoteStateS3" {
  source = "./remoteStateS3"
}
