
#====================================

resource "aws_launch_template" "lab06-apptemplate" {
  name = "lab06-application"

  image_id               = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [var.webserver_sg_id]
  user_data              = base64encode(data.template_cloudinit_config.config.rendered)

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name  = "lab06-frontend-app"
      Owner = "Eden-Jose"

    }
  }

}

#====================================

resource "aws_lb" "lab06-alb" {
  name               = "lab06-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.alb_sg_id]
  subnets            = var.public_subnets

  enable_deletion_protection = false

  tags = {
    Environment = "Prod"
  }
}

resource "aws_alb_target_group" "lab06-tg-webserver" {
  name     = "lab06-tg-webserver"
  vpc_id   = var.vpc_id
  port     = 80
  protocol = "HTTP"

  health_check {
    path                = "/"
    interval            = 10
    healthy_threshold   = 3
    unhealthy_threshold = 6
    timeout             = 5
  }
}

resource "aws_alb_target_group" "lab06-tg-api" {
  name     = "lab06-tg-api"
  vpc_id   = var.vpc_id
  port     = 8080
  protocol = "HTTP"

  health_check {
    path                = "/ok"
    interval            = 10
    healthy_threshold   = 3
    unhealthy_threshold = 6
    timeout             = 5
  }
}

resource "aws_alb_listener" "lab06-listener-front_end" {
  load_balancer_arn = aws_lb.lab06-alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.lab06-tg-webserver.arn
  }

  tags = {
    Name = "lab06-listener-front_end"
  }
}

resource "aws_alb_listener_rule" "lab06-listener-frontend_rule1" {
  listener_arn = aws_alb_listener.lab06-listener-front_end.arn
  priority     = 100

  condition {
    path_pattern {
      values = ["/"]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.lab06-tg-webserver.arn
  }

  tags = {
    Name = "lab06-listener-frontend_rule1"
  }
}

resource "aws_alb_listener_rule" "lab06-listener-api_rule1" {
  listener_arn = aws_alb_listener.lab06-listener-front_end.arn
  priority     = 10

  condition {
    path_pattern {
      values = [
        "/languages",
        "/languages/*",
        "/languages/*/*",
        "/ok"
      ]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.lab06-tg-api.arn
  }

  tags = {
    Name = "lab06-listener-api_rule1"
  }
}

#====================================

resource "aws_autoscaling_group" "lab06-asg" {
  name                = "lab06-asg"
  vpc_zone_identifier = var.private_subnets

  desired_capacity = var.asg_desired
  max_size         = var.asg_max_size
  min_size         = var.asg_min_size

  target_group_arns = [
    aws_alb_target_group.lab06-tg-webserver.arn, 
    aws_alb_target_group.lab06-tg-api.arn
    ]

  launch_template {
    id      = aws_launch_template.lab06-apptemplate.id
    version = "$Latest"
  }
}

