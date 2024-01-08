#Configure AWS provider with alias
provider "aws" {
  region  = "eu-west-2"
  profile = "terraform-user"
  alias   = "main"
}
# Allocate elastic IP for NAT Gateway in public subnet AZ1
resource "aws_eip" "eip_for_nat_gateway_az1" {
  vpc     = true

  tags = {
    Name = "nat gateway az1 eip"
  }
}

# Allocate elastic IP for NAT Gateway in public subnet AZ2
resource "aws_eip" "eip_for_nat_gateway_az2" {
  vpc     = true

  tags = {
    Name = "nat gateway az2 eip"
  }
}

# Create NAT Gateway in public subnet AZ1
resource "aws_nat_gateway" "nat_gateway_az1" {
  allocation_id = aws_eip.eip_for_nat_gateway_az1.id
  subnet_id     = aws_subnet.public_subnet_az1.id

  tags = {
    Name = "NAT Gateway AZ1"
  }

  # Ensure proper ordering by adding an explicit dependency on the internet gateway for the VPC.
  depends_on = [aws_internet_gateway.internet_gateway]
}

# Create NAT Gateway in public subnet AZ2
resource "aws_nat_gateway" "nat_gateway_az2" {
  allocation_id = aws_eip.eip_for_nat_gateway_az2.id
  subnet_id     = aws_subnet.public_subnet_az2.id

  tags = {
    Name = "NAT Gateway AZ2"
  }

  # Ensure proper ordering by adding an explicit dependency on the internet gateway for the VPC.
  depends_on = [aws_internet_gateway.internet_gateway]
}

# Create private route table AZ1 and add route through NAT Gateway AZ1
resource "aws_route_table" "private_route_table_az1" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway_az1.id
  }

  tags = {
    Name = "Private Route Table AZ1"
  }
}

# Associate private app subnet AZ1 with private route table AZ1
resource "aws_route_table_association" "private_app_subnet_az1_route_table_az1_association" {
  subnet_id      = aws_subnet.private_app_subnet_az1.id
  route_table_id = aws_route_table.private_route_table_az1.id
}

# Associate private data subnet AZ1 with private route table AZ1
resource "aws_route_table_association" "private_data_subnet_az1_route_table_az1_association" {
  subnet_id      = aws_subnet.private_data_subnet_az1.id
  route_table_id = aws_route_table.private_route_table_az1.id
}

# Create private route table AZ2 and add route through NAT Gateway AZ2
resource "aws_route_table" "private_route_table_az2" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway_az2.id
  }

  tags = {
    Name = "Private Route Table AZ2"
  }
}

# Associate private app subnet AZ2 with private route table AZ2
resource "aws_route_table_association" "private_app_subnet_az2_route_table_az2_association" {
  subnet_id      = aws_subnet.private_app_subnet_az2.id
  route_table_id = aws_route_table.private_route_table_az2.id
}

# Associate private data subnet AZ2 with private route table AZ2
resource "aws_route_table_association" "private_data_subnet_az2_route_table_az2_association" {
  subnet_id      = aws_subnet.private_data_subnet_az2.id
  route_table_id = aws_route_table.private_route_table_az2.id
}

