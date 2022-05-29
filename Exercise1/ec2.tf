#Create EC2 Instance for web tier
resource "aws_instance" "webserver" {
  count                  = var.item_count
  ami                    = var.ami_id
  instance_type          = var.instance_type
  availability_zone      = var.availability_zones[count.index]
  vpc_security_group_ids = [aws_security_group.webserver-sg.id]
  subnet_id              = aws_subnet.web-subnet[count.index].id
  user_data              = file("install_apache.sh")

  tags = {
    Name = "${var.namespace}-webServer${count.index}"
  }
}

#Create EC2 Instance for app tier
resource "aws_instance" "appserver" {
  count                  = var.item_count
  ami                    = var.ami_id
  instance_type          = var.instance_type
  availability_zone      = var.availability_zones[count.index]
  vpc_security_group_ids = [aws_security_group.appserver-sg.id]
  subnet_id              = aws_subnet.app-subnet[count.index].id
 

  tags = {
    Name = "${var.namespace}-appserver${count.index}"
  }
}