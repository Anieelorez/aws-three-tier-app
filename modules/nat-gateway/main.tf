resource "aws_eip" "eip_for_nat_gateway_az1" {
  domain = vpc

  tags   = {
    Name = "nat_gateway_az1_eip"
  }
}

resource "aws_eip" "eip_for_nat_gateway_az2" {
  domain = vpc

  tags   = {
    Name = "nat_gateway_az2_eip"
  }
}

resource "aws_eip" "eip_for_nat_gateway_az3" {
  domain = vpc

  tags   = {
    Name = "nat_gateway_az3_eip"
  }
}

# create nat gateway in public subnet az1
resource "aws_nat_gateway" "nat_gateway_az1" {
  allocation_id = aws_eip.eip_for_nat_gateway_az1.id
  subnet_id     = var.public_subnet_az1_id

  tags   = {
    Name = "nat_gateway_az1"
  }

  depends_on = [ var.internet_gateway ]
}

resource "aws_nat_gateway" "nat_gateway_az2" {
  allocation_id = aws_eip.eip_for_nat_gateway_az2.id
  subnet_id     = var.public_subnet_az2_id

  tags   = {
    Name = "nat_gateway_az2"
   
  }

  depends_on = [ var.internet_gateway ]
}

resource "aws_nat_gateway" "nat_gateway_az3" {
  allocation_id = aws_eip.eip_for_nat_gateway_az3.id
  subnet_id     = var.public_subnet_az3_id

  tags   = {
    Name = "nat_gateway_az3"
  }

  depends_on = [ var.internet_gateway ]
}

# create private route table az1 and add route through nat gateway az1
resource "aws_route_table" "private_route_table_az1" {
  vpc_id            = var.vpc_id

  route {
    cidr_block      = "0.0.0.0/0"
    nat_gateway_id  = aws_nat_gateway.nat_gateway_az1.id  
    }

  tags   = {
    Name = "private route table az1"
  }
}

# associate private app subnet az1 with private route table az1
resource "aws_route_table_association" "private_app_subnet_az1_route_table_az1_association" {
  subnet_id         = var.private_app_subnet_az1.id
  route_table_id    =  aws_route_table.private_route_table_az1.id
}

# associate private data subnet az1 with private route table az1
resource "aws_route_table_association" "private_db_subnet_az1_route_table_az1_association" {
  subnet_id         = var.private_db_subnet_az1_id
  route_table_id    = aws_route_table.private_route_table_az1.id
}

resource "aws_route_table" "private_route_table_az2" {
  vpc_id            = var.vpc_id

  route {
    cidr_block      = "0.0.0.0/0"
    nat_gateway_id  = aws_nat_gateway.nat_gateway_az2.id  
    }

  tags   = {
    Name = "private route table az2"
  }
}

# associate private app subnet az1 with private route table az2
resource "aws_route_table_association" "private_app_subnet_az2_route_table_az1_association" {
  subnet_id         = var.private_app_subnet_az2_id
  route_table_id    =  aws_route_table.private_route_table_az2.id
}

# associate private data subnet az1 with private route table az2
resource "aws_route_table_association" "private_db_subnet_az2_route_table_az1_association" {
  subnet_id         = var.private_db_subnet_az1_id
  route_table_id    = aws_route_table.private_route_table_az2.id
}

resource "aws_route_table" "private_route_table_az3" {
  vpc_id            = var.vpc_id

  route {
    cidr_block      = "0.0.0.0/0"
    nat_gateway_id  = aws_nat_gateway.nat_gateway_az3.id  
    }

  tags   = {
    Name = "private route table az3"
  }
}

# associate private app subnet az1 with private route table az3
resource "aws_route_table_association" "private_app_subnet_az3_route_table_az1_association" {
  subnet_id         = var.private_app_subnet_az3_id
  route_table_id    =  aws_route_table.private_route_table_az3.id
}

# associate private data subnet az1 with private route table az3
resource "aws_route_table_association" "private_db_subnet_az3_route_table_az1_association" {
  subnet_id         = var.private_db_subnet_az3_id
  route_table_id    = aws_route_table.private_route_table_az3.id
}