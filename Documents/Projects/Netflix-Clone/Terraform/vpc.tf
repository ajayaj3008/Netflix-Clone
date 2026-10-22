locals {
    org = "ajay"
    project = "netflix-clone"
    env = var.env
}

resource "aws_vpc" "vpc" {
    cidr_block = var.cidr_block
    instance_tenancy = "default"
    enable_dns_hostnames = true
    enable_dns_support = true

    tags = {
      name = "${local.org}-${local.project}-${local.env}-vpc"
    }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${local.org}-${local.project}-${local.env}-igw"
  }

  depends_on = [ aws_vpc.vpc ]
}

resource "aws_subnet" "public-subnet" {
    count = var.infra_count
    vpc_id = aws_vpc.vpc.id
    cidr_block = element(var.pub_cidr_block, count.index)
    availability_zone = element(var.availability_zone, count.index)
    map_public_ip_on_launch = true

    tags = {
      Name = "${local.org}-${local.project}-${local.env}-public-subnet-${count.index + 1}"
    }
    depends_on = [ aws_vpc.vpc ]
}

resource "aws_route_table" "pub-rt" {
    vpc_id = aws_vpc.vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
    depends_on = [ aws_vpc.vpc ]
}

resource "aws_route_table_association" "pub-rta" {
    count = var.infra_count
    route_table_id = aws_route_table.pub-rt.id
    subnet_id = aws_subnet.public-subnet[count.index].id

    depends_on = [ aws_vpc.vpc, aws_subnet.public-subnet ]
  
}

resource "aws_security_group" "name" {
    name = "${local.org}-${local.project}-${local.env}-pub-sg"
    description = "Default Security Group"

    vpc_id = aws_vpc.vpc.id

    ingress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
       from_port = 0
       to_port = 0
       protocol = "-1"
       cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
      Name = "${local.org}-${local.project}-${local.env}-pub-sg"
    }
}
