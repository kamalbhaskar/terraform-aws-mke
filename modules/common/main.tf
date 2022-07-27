provider "aws" {
  region  = var.region
  profile = var.profile
}

resource "aws_vpc" "mkelabVPC" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    lab = "MKE"
  }
}

resource "aws_internet_gateway" "mkelabGw" {
  vpc_id = aws_vpc.mkelabVPC.id
}

resource "aws_route_table" "mkelabRouteTable" {
  vpc_id = aws_vpc.mkelabVPC.id
  route  = []
}

resource "aws_route" "mkelabRoute" {
  route_table_id         = aws_route_table.mkelabRouteTable.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.mkelabGw.id
}

resource "aws_subnet" "mkelabSubnet" {
  vpc_id     = aws_vpc.mkelabVPC.id
  cidr_block = var.node_subnet_cidr
}

resource "aws_route_table_association" "subnetRTA" {
  subnet_id      = aws_subnet.mkelabSubnet.id
  route_table_id = aws_route_table.mkelabRouteTable.id
}

resource "aws_key_pair" "mkelabKey" {
  key_name   = "mkelabKey"
  public_key = var.public_key
}

locals {
  sg_ingress_ports = [22, 80, 443, 389, 6443, 8000, 8080, 8442]
}

resource "aws_security_group" "mkelabSG" {
  name   = "mkelabSG"
  vpc_id = aws_vpc.mkelabVPC.id

  dynamic "ingress" {
    for_each = local.sg_ingress_ports
    iterator = port
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  ingress {
    from_port   = 32768
    to_port     = 35535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    self      = true
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}