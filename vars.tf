variable "region" {
  default = ""
}

variable "region_west" {
  default = ""
}

variable "vpc_cidr" {
  default = ""
}

variable "vpc_cidr_west" {
  default = ""
}

variable "vpc_private_subnets_cidr" {
  default = []
}

variable "vpc_public_subnets_cidr" {
  default = []
}

variable "vpc_private_subnets_cidr_west" {
  default = []
}

variable "vpc_public_subnets_cidr_west" {
  default = []
}

variable "vpc_name" {
  default = ""
}

variable "public_ssh_key" {
  default = ""
}
