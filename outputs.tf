output "vpc_id" {
  value = "${module.vpc.vpc_id}"
}

output "vpc_id_west" {
  value = "${module.vpc_west.vpc_id}"
}

output "vpc_cidr_block" {
  value = "${module.vpc.vpc_cidr_block}"
}

output "vpc_cidr_block_west" {
  value = "${module.vpc_west.vpc_cidr_block}"
}

output "private_subnets" {
  value = "${module.vpc.private_subnets}"
}

output "public_subnets" {
  value = "${module.vpc.public_subnets}"
}

output "igw_id" {
  value = "${module.vpc.igw_id}"
}

output "default_security_group_id" {
  value = "${module.vpc.default_security_group_id}"
}

output "private_subnets_west" {
  value = "${module.vpc_west.private_subnets}"
}

output "public_subnets_west" {
  value = "${module.vpc_west.public_subnets}"
}

output "igw_id_west" {
  value = "${module.vpc_west.igw_id}"
}

output "peer_conn_id" {
  value = "${aws_vpc_peering_connection.peer.id}"
}

output "peer_conn_status" {
  value = "${aws_vpc_peering_connection.peer.accept_status}"
}
