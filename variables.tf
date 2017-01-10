variable "access_key" {
  description = "AWS access key"
}

variable "secret_key" {
  description = "AWS secret access key"
}

variable "aws_region" {
  description = "AWS region to launch servers."
  default = "us-east-1"
}

variable "environment" {
  description = "The environment to create/update"
  default     = "dev"
}

variable "key_name" {
  description = "Name of the SSH keypair to use in AWS."
  default = ""
}

variable "vpc_cidr" {
  description = "CIDR for VPC"
  default     = "10.1.0.0/16"
}

variable "zones" {
  description = "The number of AZs to provision infrastructure in"
  default     = "2"
}

variable "subnet_cidr" {
  default = {
    "private" = "10.1.10.0/24,10.1.20.0/24,10.1.30.0/24,10.1.40.0/24,10.1.50.0/24,10.1.60.0/24"
    "public" = "10.1.1.0/24,10.1.2.0/24,10.1.3.0/24,10.1.4.0/24,10.1.5.0/24,10.1.6.0/24"
  }
}
