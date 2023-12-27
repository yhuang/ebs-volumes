resource "aws_internet_gateway" "tamnoon" {
  vpc_id = local.tamnoon_vpc_id

  tags = {
    Name = local.tamnoon_vpc["internet-gateway-name"]
  }
}
