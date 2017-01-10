/* Dynamically grab the availability zones for this account/region */
data "aws_availability_zones" "available" {}

/* Dynamically find the latest Ubuntu Xenial AMI */
data "aws_ami" "bastion" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}
