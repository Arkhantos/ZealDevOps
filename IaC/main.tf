terraform {
  backend "local" {
    path = "dev/ec2/terraform.tfstate"
  }
}

# -------------------------
# Define el provider de AWS
# -------------------------
provider "aws" {
  region  = local.region
  profile = "terraprofile"
}

locals {
  region = var.region
  ami    = var.ubuntu_ami[local.region]
}


# ------------------------------------
# Data source que obtiene el id del AZ
# ------------------------------------
data "aws_vpc" "vpc-default" {
  default = true
}

data "aws_subnets" "all_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc-default.id]
  }
}

data "aws_subnet" "public_subnet" {
  for_each          = var.servers_ec2
  availability_zone = "${local.region}${each.value.az}"
  vpc_id            = data.aws_vpc.vpc-default.id
}

# ------------------------------------
# EC2 module
# ------------------------------------
module "ec2-instance" {
  source = "./modules/aws_ec2"

  env           = "dev"
  instance_type = var.instance_type
  ami_id        = var.ubuntu_ami[local.region]
  servers_ec2 = {
    for id_ser, info in var.servers_ec2 :
    id_ser => { name = info.name, subnet_id = data.aws_subnet.public_subnet[id_ser].id }
  }
}

# ------------------------------------
# ALB module
# ------------------------------------
module "load_balancer" {
  source = "./modules/aws_alb"

  subnet_ids     = data.aws_subnets.all_subnets.ids
  instance_ids   = module.ec2-instance.ec2_instance_ids
  vpc_default_id = data.aws_vpc.vpc-default.id
  port_lb        = var.port_lb
  server_port    = var.server_port
  env            = "dev"
  ip_allow       = var.ip_allow
}
