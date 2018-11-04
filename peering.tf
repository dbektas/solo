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

resource "aws_subnet" "public_subnet" {
  vpc_id     = "${module.vpc.vpc_id}"
  depends_on = ["module.vpc"]
  cidr_block        = "10.0.7.0/24"
  #availability_zone = "${element(var.azs, count.index)}"
  map_public_ip_on_launch = true

  tags {
    Name = "peering"
  }
}

resource "aws_subnet" "public_subnet_west" {
  provider = "aws.ireland"
  vpc_id     = "${module.vpc_west.vpc_id}"
  depends_on = ["module.vpc_west"]
  cidr_block        = "10.0.14.0/24"
  #availability_zone = "${element(var.azs, count.index)}"
  map_public_ip_on_launch = true

  tags {
    Name = "peering"
  }
}

resource "aws_route_table" "requester_peering_route" {
  vpc_id = "${module.vpc.vpc_id}"

  route {
    cidr_block = "${aws_subnet.public_subnet_west.cidr_block}"
    vpc_peering_connection_id = "${aws_vpc_peering_connection.peer.id}"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${module.vpc.igw_id}"
  }

  tags {
    Name = "peering"
  }
}

resource "aws_route_table" "accepter_peering_route" {
  provider = "aws.ireland"
  vpc_id = "${module.vpc_west.vpc_id}"

  route {
    cidr_block = "${aws_subnet.public_subnet.cidr_block}"
    vpc_peering_connection_id = "${aws_vpc_peering_connection_accepter.peer.id}"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${module.vpc_west.igw_id}"
  }

  tags {
    Name = "peering"
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = "${aws_subnet.public_subnet.id}"
  route_table_id = "${aws_route_table.requester_peering_route.id}"
}

resource "aws_route_table_association" "public_west" {
  provider = "aws.ireland"
  subnet_id      = "${aws_subnet.public_subnet_west.id}"
  route_table_id = "${aws_route_table.accepter_peering_route.id}"
}
