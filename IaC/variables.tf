variable "ubuntu_ami" {
  description = "AMI per region"
  type        = map(string)

  default = {
    us-east-1 = "ami-053b0d53c279acc90" # Ubuntu in virginia
    us-west-2 = "ami-005383956f2e5fb96" # Ubuntu en oregon
  }
}

variable "server-ec2" {
  description = "Mapa de servidores con su correspondiente AZ"

  type = map(string)

  default = {
    name = "server-1",
    az   = "a"
  }

}

variable "region" {}
variable "instance_type" {}
