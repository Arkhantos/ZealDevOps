output "dns_load_balancer" {
  description = "Public DNS of the load balancer"
  value       = "http://${aws_lb.this.dns_name}:${var.port_lb}"
}
