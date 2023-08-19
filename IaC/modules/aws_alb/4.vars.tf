variable "subnet_ids" {
  description = "All subnet-ids where the ALB is provisioned"
  type        = set(string)
}

variable "instance_ids" {
  description = "all instance ids"
  type        = list(string)
}

variable "port_lb" {
  description = "Load balancer port"
  type        = number
  default     = 80
}

variable "server_port" {
  description = "Port for the ec2 instances"
  type        = number
  default     = 8080

  validation {
    condition     = var.server_port > 0 && var.server_port <= 65536
    error_message = "Must be between 1 and 65536."
  }
}

variable "env" {
  description = "Environment name."
  type        = string
}

variable "vpc_default_id" {
  description = "vpc id"
  type        = string
}

variable "ip_allow" {
  description = "IP restricted ingress"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}
