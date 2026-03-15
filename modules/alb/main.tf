resource "aws_lb" "alb" {
  name               = "application-lb"
  load_balancer_type = "application"
  subnets            = var.subnets
}

