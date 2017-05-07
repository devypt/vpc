resource "aws_internet_gateway" "default" {
  vpc_id = "${aws_vpc.vpc.id}"

  lifecycle {
    create_before_destroy = true
  }

  tags {
    Name        = "${var.environment}-igw"
    Environment = "${var.environment}"
  }
}

resource "aws_subnet" "public" {
  count                   = "${var.zones}"
  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "${element(split(",", lookup(var.subnet_cidr, "public")), count.index)}"
  availability_zone       = "${element(data.aws_availability_zones.available.names, count.index)}"
  map_public_ip_on_launch = true
  depends_on              = ["aws_internet_gateway.default"]

  lifecycle {
    create_before_destroy = true
  }

  tags {
    Name        = "${var.environment}-public-subnet-${count.index}"
    Environment = "${var.environment}"
    SubnetType  = "public"
  }
}

resource "aws_route_table" "public" {
  count  = "${var.zones}"
  vpc_id = "${aws_vpc.vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.default.id}"
  }

  lifecycle {
    create_before_destroy = true
  }

  tags {
    Name        = "${var.environment}-public-rt-${count.index}"
    Environment = "${var.environment}"
  }
}

resource "aws_route_table_association" "public" {
  count           = "${var.zones}"
  subnet_id       = "${element(aws_subnet.public.*.id, count.index)}"
  route_table_id  = "${element(aws_route_table.public.*.id, count.index)}"
}
