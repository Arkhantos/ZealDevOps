variable "server_port" {
  description = "Port for the ec2 instances"
  type        = number
  default     = 8080

  validation {
    condition     = var.server_port > 0 && var.server_port <= 65536
    error_message = "Must be between 1 and 65536."
  }
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance(s). Defaults to Amazon Linux 2 (Virginia)"
  type        = string
  default     = "ami-0ab4d1e9cf9a1215a"
}

variable "instance_type" {
  description = "Instance type. Defaults to t3a.micro"
  type        = string
  default     = "t3a.micro"
}

variable "servers_ec2" {
  description = "Server Map with its corresponding public subnet"

  type = map(object({
    name      = string,
    subnet_id = string
    })
  )
}

variable "iam_role" {
  description = "IAM Role to be attached to the instance"
  type        = string
  default     = ""
}

variable "root_size" {
  description = "Size in GiB for the EC2 instance's root volume"
  type        = number
  default     = 30
}

variable "env" {
  description = "Environment name."
  type        = string
}


variable "key_name" {
  description = "SSH key to be used with the EC2 instances"
  type        = string
  default     = null
}
