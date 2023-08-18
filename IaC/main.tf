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

data "aws_subnet" "public_subnet" {
  availability_zone = "${local.region}${var.server-ec2["az"]}"
  vpc_id            = data.aws_vpc.vpc-default.id
}

# ------------------------------------
# EC2
# ------------------------------------
module "ec2-instance" {
  source = "./modules/aws_ec2"

  env           = "dev"
  instance_type = var.instance_type
  ami_id        = var.ubuntu_ami[local.region]
  server-ec2 = {
    name      = var.server-ec2["name"],
    subnet_id = data.aws_subnet.public_subnet.id
  }
}

