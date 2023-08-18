# ------------------------------------------------------
# Define a security group
# ------------------------------------------------------
resource "aws_security_group" "this" {
  name = "first-sg"

  ingress {
    description = "Access the server port from other device"
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
