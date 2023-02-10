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
  cidr_block = "10.0.${0+count.index}.0/24"
  availability_zone = "${data.aws_availability_zones.available.names[count.index]}"
  tags = {
    name = "PublicSubnet"
  }
}

data "aws_ami" "awsImage" {
  most_recent = true
  filter {
    name = "name"
    values = [ "${var.imageid}" ]
  }
}
resource "aws_launch_template" "foo" {
  name = "test"
  image_id = data.aws_ami.awsImage.id
  instance_type = "t2.micro"
}
resource "aws_autoscaling_group" "scaler" {
  vpc_zone_identifier = [ for subnet in aws_subnet.main : subnet.id ]
  desired_capacity = 3
  max_size = 4
  min_size = 1

  launch_template {
    id = aws_launch_template.foo.id
  }
}