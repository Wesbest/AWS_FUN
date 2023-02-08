
resource "aws_vpc" "main" {
  cidr_block       = var.cidr_block
  instance_tenancy = "default"
  tags = {
    name = var.environment
  }
  enable_dns_hostnames = true
  enable_dns_support = true
}

data "aws_availability_zones" "available" {}

resource "aws_subnet" "main" {
  count = "${length(data.aws_availability_zones.available.names)}"
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.${20+count.index}.0/24"
  availability_zone = "${data.aws_availability_zones.available.names[count.index]}"
  tags = {
    name = "PublicSubnet"
  }
}