provider "aws" {
  region = "${var.region}"
}

provider "aws" {
  alias = "ireland"
  region = "${var.region_west}"
}

resource "aws_vpc" "main" {
  cidr_block = "${module.vpc_cidr_block}"
}

resource "aws_vpc" "peer" {
  provider   = "aws.ireland"
  cidr_block = "${module.vpc_west.vpc_cidr_block}"
}

# Requester's side of the connection.
resource "aws_vpc_peering_connection" "peer" {
  vpc_id        = "${module.vpc.vpc_id}"
  peer_vpc_id   = "${module.vpc_west.vpc_id}"
  peer_region   = "eu-west-1"
  auto_accept   = true

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
    cidr_block = "${module.vpc.vpc_cidr_block}"
    vpc_peering_connection_id = "${aws_vpc_peering_connection.peer.id}"
  }
}

resource "aws_route_table" "accepter_peering_route" {
  provider = "aws.ireland"
  vpc_id = "${module.vpc_west.vpc_id}"

  route {
    cidr_block = "${module.vpc_west.vpc_cidr_block}"
    vpc_peering_connection_id = "${aws_vpc_peering_connection_accepter.peer.id}"
  }
}
