resource "aws_instance" "bastion" {
  ami                     = "${data.aws_ami.bastion.id}"
  source_dest_check       = false
  instance_type           = "t2.nano"
  subnet_id               = "${aws_subnet.public.0.id}"
  key_name                = "${var.key_name}"
  vpc_security_group_ids  = ["${aws_security_group.bastion-server.id}"]

  tags  {
    Name        = "${var.environment}-bastion"
    Environment = "${var.environment}"
  }
}

resource "aws_eip" "bastion" {
  depends_on  = ["aws_instance.bastion"]
  instance    = "${aws_instance.bastion.id}"
  vpc         = true
}

resource "aws_security_group" "bastion-server" {
  name        = "bastion-server-sg"
  description = "Allow inbound on 22 from anywhere"
  vpc_id = "${aws_vpc.vpc.id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
