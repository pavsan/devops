# Create Web Public Subnet
resource "aws_subnet" "web-subnet" {
  count                   = var.item_count
  vpc_id                  = aws_vpc.login-vpc.id
  cidr_block              = var.cidr_block_web[count.index]
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.namespace}-web-${count.index}"
  }
}

# Create app private Subnet
resource "aws_subnet" "app-subnet" {
  count                   = var.item_count
  vpc_id                  = aws_vpc.login-vpc.id
  cidr_block              = var.cidr_block_app[count.index]
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.namespace}-app-${count.index}"
  }
}

# Create app private Subnet
resource "aws_subnet" "db-subnet" {
  count                   = var.item_count
  vpc_id                  = aws_vpc.login-vpc.id
  cidr_block              = var.cidr_block_db[count.index]
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.namespace}-db-${count.index}"
  }
}