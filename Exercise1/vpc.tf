data "aws_availability_zones" "available" {}

resource "aws_vpc" "login-vpc" {
  cidr_block       = var.cidr 
  instance_tenancy = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "Login Application VPC"
  }
}


