account_id = "341697886451"
region = "eu-central-1"
region_west = "eu-west-1"
azs_west = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
vpc_cidr = "10.0.0.0/16"
vpc_name = "iac-vpc"
vpc_private_subnets_cidr = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
vpc_public_subnets_cidr = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
vpc_private_subnets_cidr_west = ["10.0.10.0/24", "10.0.20.0/24", "10.0.30.0/24"]
vpc_public_subnets_cidr_west = ["10.0.111.0/24", "10.0.112.0/24", "10.0.113.0/24"]
principals = [
  "arn:aws:iam::341697886451:root",
  "arn:aws:iam::341697886451:user/eastwood777"
]
