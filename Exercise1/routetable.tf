# Create Web layer route tablevpc_id = aws_vpc.login-vpc.id
resource "aws_route_table" "login-web-rt" {
    vpc_id = aws_vpc.login-vpc.id
    
    route {
        cidr_block = var.cidr_block_default
        gateway_id = aws_internet_gateway.login-igw.id
    }

  tags = {
    Name = "${var.namespace}-web-RT"
  }
}

# Create Web Subnet association with Web route table
resource "aws_route_table_association" "login-rt-association" {
  count          = var.item_count
  subnet_id      = aws_subnet.web-subnet[count.index].id
  route_table_id = aws_route_table.login-web-rt.id
}