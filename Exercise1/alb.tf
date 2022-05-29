
#Create web tier Load Balancer
resource "aws_lb" "login-web-external-lb" {
  name               = "External-LB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.web-sg.id]
  subnets            = [aws_subnet.web-subnet[0].id, aws_subnet.web-subnet[1].id]
}

resource "aws_lb_target_group" "login-web-external-lb" {
  name     = "ALB-TG"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.login-vpc.id
}

resource "aws_lb_target_group_attachment" "login-web-external-lb" {
  count            = var.item_count
  target_group_arn = aws_lb_target_group.login-web-external-lb.arn
  target_id        = aws_instance.webserver[count.index].id
  port             = 80

  depends_on = [
    aws_instance.webserver[1]
  ]
}

resource "aws_lb_listener" "login-web-external-lb" {
  load_balancer_arn = aws_lb.login-web-external-lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.login-web-external-lb.arn
  }
}

#Create app tier Load Balancer
resource "aws_lb" "login-app-internal-lb" {
  name               = "External-LB"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.app-sg.id]
  subnets            = [aws_subnet.app-subnet[0].id, aws_subnet.app-subnet[1].id]
}

resource "aws_lb_target_group" "login-app-internal-lb" {
  name     = "ALB-TG"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.login-vpc.id
}

resource "aws_lb_target_group_attachment" "login-app-internal-lb" {
  count            = var.item_count
  target_group_arn = aws_lb_target_group.login-app-internal-lb.arn
  target_id        = aws_instance.appserver[count.index].id
  port             = 80

  depends_on = [
    aws_instance.app[1]
  ]
}

resource "aws_lb_listener" "login-app-internal-lb" {
  load_balancer_arn = aws_lb.login-app-internal-lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.login-app-internal-lb.arn
  }
}
