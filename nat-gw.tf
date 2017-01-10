resource "aws_eip" "nat" {
  count = "${var.zones}"
  vpc   = true

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_nat_gateway" "nat" {
  depends_on    = ["aws_eip.nat"]
  count         = "${var.zones}"
  allocation_id = "${element(aws_eip.nat.*.id, count.index)}"
  subnet_id     = "${element(aws_subnet.public.*.id, count.index)}"
  depends_on    = ["aws_internet_gateway.default","aws_subnet.private"]

  lifecycle {
    create_before_destroy = true
  }
}
