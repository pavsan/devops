# Create Internet Gateway
resource "aws_internet_gateway" "login-igw" {
  vpc_id = aws_vpc.login-vpc.id

  tags = {
    Name = "${var.namespace}-IGW"
  }
}

resource "aws_nat_gateway" "login-nat-gateway" {
  allocation_id = aws_eip.login-elastic-ip.id
  subnet_id     = aws_subnet.web-subnet.id

  tags = {
    Name = "${var.namespace}-gw-NAT"
  }

   depends_on = [aws_internet_gateway.login-igw]
}