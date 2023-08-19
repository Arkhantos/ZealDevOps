# ----------------------------------
# Target Group para el Load Balancer
# ----------------------------------
resource "aws_lb_target_group" "this" {
  name     = "terraformers-alb-target-group"
  port     = var.port_lb
  vpc_id   = var.vpc_default_id
  protocol = "HTTP"

  health_check {
    enabled  = true
    matcher  = "200"
    path     = "/"
    port     = var.server_port
    protocol = "HTTP"
  }
}

# ------------------------------
# Attachment for servers
# ------------------------------
resource "aws_lb_target_group_attachment" "this" {
  count = length(var.instance_ids)

  target_group_arn = aws_lb_target_group.this.arn
  target_id        = element(var.instance_ids, count.index)
  port             = var.server_port
}

# ------------------------
# Listener for the LB
# ------------------------
resource "aws_lb_listener" "this" {

  load_balancer_arn = aws_lb.this.arn
  port              = var.port_lb

  default_action {
    target_group_arn = aws_lb_target_group.this.arn
    type             = "forward"
  }
}

resource "aws_lb_listener_rule" "this" {
  listener_arn = aws_lb_listener.this.arn

  action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }

  condition {
    host_header {
      values = ["example.com"]
    }
  }
}

resource "aws_lb_listener" "second_listener" {
  load_balancer_arn = aws_lb.this.arn
  port              = "81"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}


# No se usa certificado debido a que no se tiene un dominio valido
/*
resource "aws_acm_certificate" "this" {
  domain_name       = "example.com"
  validation_method = "DNS"

  tags = {
    Name = "example.com SSL certificate"
  }
}

# Associate the SSL certificate with the ALB listener
resource "aws_lb_listener_certificate" "this" {
  listener_arn = aws_lb_listener.this.arn
  certificate_arn = aws_acm_certificate.this.arn
}*/
