# ----------------------------------------
# Public Load Balancer with one instance
# ----------------------------------------
resource "aws_lb" "this" {
  load_balancer_type = "application"
  name               = "terraformers-alb"
  security_groups    = [aws_security_group.this.id]

  subnets = var.subnet_ids
  /*
  subnet_mapping {
    subnet_id            = var.subnet_ids #aws_subnet.example1.id
    private_ipv4_address = var.ip_allow   #"10.0.1.15"
  }*/
}

# ------------------------------------
# Security group para el Load Balancer
# ------------------------------------
resource "aws_security_group" "this" {
  name = "alb-sg"

  ingress {
    cidr_blocks = var.ip_allow
    description = "Access from the external side to the LB Port"
    from_port   = var.port_lb
    to_port     = var.port_lb
    protocol    = "TCP"
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "Acess to our server Port"
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = "TCP"
  }
}
