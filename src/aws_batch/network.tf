
# VPC
resource "aws_vpc" "sandbox" {
  cidr_block = "${var.vpc_cidr}"
  instance_tenancy = "default"
  enable_dns_support = "true"
  enable_dns_hostnames = "true"
  tags {
    Name = "sandbox"
  }
}

# EIP
resource "aws_eip" "nat" {
    vpc = true
}

# InternetGateway
resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.sandbox.id}"
}

# NatGateway
resource "aws_nat_gateway" "nat" {
  allocation_id = "${aws_eip.nat.id}"
  subnet_id = "${aws_subnet.public-a.id}"
}

# Subnet
resource "aws_subnet" "public-a" {
  vpc_id = "${aws_vpc.sandbox.id}"
  cidr_block = "${var.subnet_public1a_cidr}"
  availability_zone = "ap-northeast-1a"
  tags {
    Name = "subnet_public1a"
  }
}

resource "aws_subnet" "public-c" {
  vpc_id = "${aws_vpc.sandbox.id}"
  cidr_block = "${var.subnet_public1c_cidr}"
  availability_zone = "ap-northeast-1c"
  tags {
    Name = "subnet_public1c"
  }
}

resource "aws_subnet" "private-a" {
  vpc_id = "${aws_vpc.sandbox.id}"
  cidr_block = "${var.subnet_private1a_cidr}"
  availability_zone = "ap-northeast-1a"
  tags {
    Name = "subnet_private1a"
  }
}

resource "aws_subnet" "private-c" {
  vpc_id = "${aws_vpc.sandbox.id}"
  cidr_block = "${var.subnet_private1c_cidr}"
  availability_zone = "ap-northeast-1c"
  tags {
    Name = "subnet_private1c"
  }
}

# RouteTable
resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.sandbox.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }
  tags {
    Name = "route_table_public"
  }
}

resource "aws_route_table" "private" {
  vpc_id = "${aws_vpc.sandbox.id}"
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.nat.id}"
  }
  tags {
    Name = "route_table_private"
  }
}

# SubnetRouteTableAssociation
resource "aws_route_table_association" "public-a" {
    subnet_id = "${aws_subnet.public-a.id}"
    route_table_id = "${aws_route_table.public.id}"
}

resource "aws_route_table_association" "public-c" {
    subnet_id = "${aws_subnet.public-c.id}"
    route_table_id = "${aws_route_table.public.id}"
}

resource "aws_route_table_association" "private-a" {
    subnet_id = "${aws_subnet.private-a.id}"
    route_table_id = "${aws_route_table.private.id}"
}

resource "aws_route_table_association" "private-c" {
    subnet_id = "${aws_subnet.private-c.id}"
    route_table_id = "${aws_route_table.private.id}"
}
