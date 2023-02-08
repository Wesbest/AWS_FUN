
resource "aws_vpc" "main" {
  cidr_block       = var.cidr_block
  instance_tenancy = "default"
  tags = {
    name = var.environment
  }
  enable_dns_hostnames = true
  enable_dns_support = true
}

resource "aws_subnet" "main" {
  for_each = var.subnets
  vpc_id = aws_vpc.main.id
  cidr_block = "${each.value}"
  tags = {
    name = "${each.key}"
  }
}