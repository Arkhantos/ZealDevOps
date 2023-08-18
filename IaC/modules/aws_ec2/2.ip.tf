
# ------------------------------------------------------
# Create EIP 
# ------------------------------------------------------
resource "aws_eip" "this" {
  vpc = true
}

# ------------------------------------------------------
# Associate EIP with EC2 Instance
# ------------------------------------------------------
resource "aws_eip_association" "this" {
  instance_id   = aws_instance.this.id
  allocation_id = aws_eip.this.id
}
