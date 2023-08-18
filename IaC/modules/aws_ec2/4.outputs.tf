output "ec2_instance_ids" {
  description = "EC2 instance ID"
  value       = aws_instance.this.id
}

output "elastic_ip" {
  description = "EIP Public Ip"
  value       = aws_eip.this.public_ip
}
