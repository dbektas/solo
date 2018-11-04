account_id = "341697886451"
region = "eu-central-1"
region_west = "eu-west-1"
vpc_cidr = "10.0.0.0/21"
vpc_cidr_west = "10.0.8.0/21"
vpc_name = "iac-vpc"
vpc_private_subnets_cidr = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
vpc_public_subnets_cidr = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
vpc_private_subnets_cidr_west = ["10.0.8.0/24", "10.0.9.0/24", "10.0.10.0/24"]
vpc_public_subnets_cidr_west = ["10.0.11.0/24", "10.0.12.0/24", "10.0.13.0/24"]
principals = [
  "arn:aws:iam::341697886451:root",
  "arn:aws:iam::341697886451:user/eastwood777"
]
