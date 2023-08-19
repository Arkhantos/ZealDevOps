
# ------------------------------------------------------
# Create EIP 
# ------------------------------------------------------
resource "aws_eip" "this" {
  for_each = var.servers_ec2
  vpc      = true
}

# ------------------------------------------------------
# Associate EIP with EC2 Instance
# ------------------------------------------------------
resource "aws_eip_association" "this" {
  for_each      = var.servers_ec2
  instance_id   = aws_instance.this[each.key].id
  allocation_id = aws_eip.this[each.key].id
}
