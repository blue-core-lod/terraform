# VPC Resource
resource "aws_vpc" "bluecore-dev" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    name      = "bluecore-dev"
    terraform = "true"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "bluecore-dev" {
  vpc_id = aws_vpc.bluecore-dev.id

  tags = {
    name      = "bluecore-dev"
    terraform = "true"
  }
}

# Public Subnet
resource "aws_subnet" "bluecore-dev" {
  vpc_id                  = aws_vpc.bluecore-dev.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone = var.availability_zone

  tags = {
    name      = "bluecore-dev"
    terraform = "true"
  }
}

# Route Table
resource "aws_route_table" "bluecore-dev" {
  vpc_id = aws_vpc.bluecore-dev.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.bluecore-dev.id
  }

  tags = {
    name      = "bluecore-dev"
    terraform = "true"
  }
}

# Route Table Association
resource "aws_route_table_association" "bluecore-dev" {
  subnet_id      = aws_subnet.bluecore-dev.id
  route_table_id = aws_route_table.bluecore-dev.id
}
