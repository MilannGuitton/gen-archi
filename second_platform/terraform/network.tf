# -------------------------------------------------------- Network session --- #

data "aws_eip" "public_ip" {
  public_ip = "13.36.46.172"
}

resource "aws_eip_association" "associate_front" {
  instance_id   = aws_instance.frontend.id
  allocation_id = data.aws_eip.public_ip.id
}