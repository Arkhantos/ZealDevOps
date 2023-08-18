# ---------------------------------------
# Define the EC2 instance
# ---------------------------------------
resource "aws_instance" "this" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.server-ec2["subnet_id"]
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.this.id]
  iam_instance_profile   = var.iam_role

  root_block_device {
    volume_size           = var.root_size
    delete_on_termination = true
    tags = {
      Name = "My ebs"
    }
    volume_type = "standard"
  }

  lifecycle {
    ignore_changes = [tags, user_data]
  }

  tags = {
    Name = "${var.server-ec2["name"]}-${var.env}"
  }
}
