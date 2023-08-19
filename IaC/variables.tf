variable "ubuntu_ami" {
  description = "AMI per region"
  type        = map(string)

  default = {
    us-east-1 = "ami-053b0d53c279acc90" # Ubuntu in virginia
    us-west-2 = "ami-005383956f2e5fb96" # Ubuntu en oregon
  }
}

variable "servers_ec2" {
  description = "Mapa de servidores con su correspondiente AZ"

  type = map(object({
    name = string,
    az     = string
    })
  )

  default = {
    "ser-1" = { name = "servidor-1", az = "a" },
    "ser-2" = { name = "servidor-2", az = "b" },
  }

}

variable "ip_allow" {
  description = "IP restricted ingress"
  type        = list(string)
}

variable "region" {}
variable "instance_type" {}
variable "port_lb" {}
variable "server_port" {}
