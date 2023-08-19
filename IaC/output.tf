output "ec2_instance_ids" {
  value = module.ec2-instance.ec2_instance_ids
}

output "elastic_ip" {
  value = module.ec2-instance.elastic_ip
}

output "dns_load_balancer" {
  description = "DNS pública del load balancer"
  value       = module.load_balancer.dns_load_balancer
}
