resource "aws_eip" "login-elastic-ip" {
  vpc  = true
  tags = {
    Name = "${var.namespace}-elasticIP"
  }
}