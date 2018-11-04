# Requester's side of the connection.
resource "aws_vpc_peering_connection" "peer" {
  vpc_id        = "${module.vpc.vpc_id}"
  peer_vpc_id   = "${module.vpc_west.vpc_id}"
  peer_region   = "${var.region_west}"
  auto_accept   = false

  tags {
    Side = "Requester"
  }
}

# Accepter's side of the connection.
resource "aws_vpc_peering_connection_accepter" "peer" {
  provider                  = "aws.ireland"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.peer.id}"
  auto_accept               = true

  tags {
    Side = "Accepter"
  }
}

resource "aws_route_table" "requester_peering_route" {
  vpc_id = "${module.vpc.vpc_id}"

  route {
    cidr_block = "${var.vpc_private_subnets_cidr_west[0]}"
    vpc_peering_connection_id = "${aws_vpc_peering_connection.peer.id}"
  }
}

resource "aws_route_table" "accepter_peering_route" {
  provider = "aws.ireland"
  vpc_id = "${module.vpc_west.vpc_id}"

  route {
    cidr_block = "${var.vpc_private_subnets_cidr[0]}"
    vpc_peering_connection_id = "${aws_vpc_peering_connection_accepter.peer.id}"
  }
}
