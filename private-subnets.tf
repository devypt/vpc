resource "aws_subnet" "private" {
  count                   = "${var.zones}"
  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "${element(split(",", lookup(var.subnet_cidr, "private")), count.index)}"
  availability_zone       = "${element(data.aws_availability_zones.available.names, count.index)}"
  map_public_ip_on_launch = false

  lifecycle {
    create_before_destroy = true
  }

  tags {
    Name        = "${var.environment}-private-subnet-${count.index}"
    Environment = "${var.environment}"
  }
}

resource "aws_route_table" "private" {
  count  = "${var.zones}"
  vpc_id = "${aws_vpc.vpc.id}"

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "${element(aws_nat_gateway.nat.*.id, count.index)}"
  }

  lifecycle {
    create_before_destroy = true
  }

  tags {
    Name        = "${var.environment}-private-rt-${count.index}"
    Environment = "${var.environment}"
  }
}

/* Associate the private route table with the private subnets */
resource "aws_route_table_association" "private" {
  count           = "${var.zones}"
  subnet_id       = "${element(aws_subnet.private.*.id, count.index)}"
  route_table_id  = "${element(aws_route_table.private.*.id, count.index)}"

  lifecycle {
    create_before_destroy = true
  }
}
