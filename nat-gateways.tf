resource "aws_eip" "tamnoon_public_nat_gateway" {
  for_each = local.tamnoon_subnet["public"]

  domain = "vpc"
}

resource "aws_nat_gateway" "tamnoon_public" {
  for_each = local.tamnoon_subnet["public"]

  connectivity_type = "public"
  allocation_id     = local.tamnoon_nat_gateway[each.key]["ip"]
  subnet_id         = local.tamnoon_subnet_object["public"][each.key]["id"]

  tags = {
    Name = local.tamnoon_nat_gateway[each.key]["name"]
  }

  # add an explicit dependency on the VPC's internet gaateway to ensure proper ordering
  depends_on = [
    aws_internet_gateway.tamnoon
  ]
}
