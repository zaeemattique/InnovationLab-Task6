resource "aws_lb" "Task6-ALB-Zaeem" {
  name               = "Task6-ALB-Zaeem"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.alb_sg_id]
  subnets            = [var.public_sna_id, var.public_snb_id]

  enable_deletion_protection = false
  tags = {
    Name = "Task6-ALB-Zaeem"
  }
  
}

resource "aws_lb_target_group" "Task6-ALB-Target-Group-Zaeem" {
  name     = "Task6-ALB-Target-Group-Zaeem"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  target_type = "instance"

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }

  tags = {
    Name = "Task6-ALB-Target-Group-Zaeem"
  }
}

resource "aws_lb_listener" "Task6-ALB-Listener-Zaeem" {
  load_balancer_arn = aws_lb.Task6-ALB-Zaeem.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.Task6-ALB-Target-Group-Zaeem.arn
  }
}


