# -------------------------------------------------------- Network session --- #

data "aws_eip" "public_ip" {
  public_ip = "35.181.111.83"
}

resource "aws_eip_association" "associate_front" {
  instance_id   = aws_instance.frontend.id
  allocation_id = data.aws_eip.public_ip.id
}