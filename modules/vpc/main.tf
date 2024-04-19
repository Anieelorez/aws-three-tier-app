resource "aws_vpc" "vpc_project" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = default
  enable_dns_hostnames = true

  tags = {
    Name = "${var.vpc_project_name}-vpc"
  }
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id    = aws_vpc.vpc_project.id

  tags      = {
    Name    = "${var.vpc_project_name}-vpc"
  }
}

data "aws_availability_zone" "availability_zones" {}


resource "aws_subnet" "public_subnet_az1" {
  vpc_id     = aws_vpc.vpc_project.id
  cidr_block = var.public_subnet_az1_cidr
  availability_zone = data.aws_availability_zone.availability_zones_names[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "public_subnet_az1"
  }
}

resource "aws_subnet" "public_subnet_az2" {
  vpc_id     = aws_vpc.vpc_project.id
  cidr_block = var.public_subnet_az2_cidr
  availability_zone = data.aws_availability_zone.availability_zones.names[1]
  map_public_ip_on_launch = true

  tags = {
    Name = "public_subnet_az2"
  }
}

resource "aws_subnet" "public_subnet_az3" {
  vpc_id     = aws_vpc.vpc_project.id
  cidr_block = var.public_subnet_az3_cidr
  availability_zone = data.aws_availability_zone.availability_zones.names[2]
  map_public_ip_on_launch = false

  tags = {
    Name = "public_subnet_az3"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id       = aws_vpc.vpc_project.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags       = {
    Name     = "public-route-table"
  }
}

# associate public subnet az1 to "public route table"
resource "aws_route_table_association" "public_subnet_az1_route_table_association" {
  subnet_id           = aws_subnet.public_subnet_az1.id
  route_table_id      = aws_route_table.public_route_table.id
}

# associate public subnet az2 to "public route table"
resource "aws_route_table_association" "public_subnet_az2_route_table_association" {
  subnet_id           = aws_subnet.public_subnet_az2.id
  route_table_id      = aws_route_table.public_route_table.id
}
# associate public subnet az3 to "public route table"
resource "aws_route_table_association" "public_subnet_az3_route_table_association" {
  subnet_id           = aws_subnet.public_subnet_az3.id
  route_table_id      = aws_route_table.public_route_table.id
}

resource "aws_subnet" "private_app_subnet_az1" {
  vpc_id     = aws_vpc.vpc_project.id
  cidr_block = var.private_app_subnet_az1_cidr
  availability_zone = data.aws_availability_zone.availability_zones.names[0]
  map_public_ip_on_launch = false

  tags = {
    Name = "private_app_subnet_az1"
  }
}

resource "aws_subnet" "private_app_subnet_az2" {
  vpc_id     = aws_vpc.vpc_project.id
  cidr_block = var.private_app_subnet_az2_cidr
  availability_zone = data.aws_availability_zone.availability_zones.names[1]
  map_public_ip_on_launch = false

  tags = {
    Name = "private_app_subnet_az2"
  }
}

resource "aws_subnet" "private_app_subnet_az3" {
  vpc_id     = aws_vpc.vpc_project.id
  cidr_block = var.private_app_subnet_az3_cidr
  availability_zone = data.aws_availability_zone.availability_zones.names[2]
  map_public_ip_on_launch = false

  tags = {
    Name = "private_app_subnet_az3"
  }
}

resource "aws_subnet" "private_db_subnet_az1" {
  vpc_id     = aws_vpc.vpc_project.id
  cidr_block = var.private_db_subnet_az1_cidr
  availability_zone = data.aws_availability_zone.availability_zones.names[0]
  map_public_ip_on_launch = false

  tags = {
    Name = "private_db_subnet_az1"
  }
}

resource "aws_subnet" "private_db_subnet_az2" {
  vpc_id     = aws_vpc.vpc_project.id
  cidr_block = var.private_app_subnet_az2_cidr
  availability_zone = data.aws_availability_zone.availability_zones.names[1]
  map_public_ip_on_launch = false

  tags = {
    Name = "private_db_subnet_az2"
  }
}

resource "aws_subnet" "private_db_subnet_az3" {
  vpc_id     = aws_vpc.vpc_project.id
  cidr_block = var.private_app_subnet_az3_cidr
  availability_zone = data.aws_availability_zone.availability_zones.names[2]
  map_public_ip_on_launch = false

  tags = {
    Name = "private_db_subnet_az3"
  }
}
