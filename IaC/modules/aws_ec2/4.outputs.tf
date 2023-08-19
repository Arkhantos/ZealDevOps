output "ec2_instance_ids" {
  description = "EC2 instance ID"
  value       = [for servidor in aws_instance.this : servidor.id]
}

output "elastic_ip" {
  description = "EIP Public Ip"
  value       = [for eip in aws_eip.this : eip.public_ip]
}
