resource "aws_subnet" "tamnoon_private" {
  for_each = local.tamnoon_subnet["private"]

  availability_zone = each.key
  vpc_id            = local.tamnoon_vpc_id
  cidr_block        = each.value["cidr-block"]

  tags = {
    Name = each.value["name"]
  }
}

resource "aws_route_table" "tamnoon_private_subnet" {
  for_each = local.tamnoon_subnet["private"]

  vpc_id = local.tamnoon_vpc_id

  tags = {
    Name = local.tamnoon_route_table["private"][each.key]["name"]
  }
}

resource "aws_route_table_association" "tamnoon_private_subnet" {
  for_each = local.tamnoon_subnet["private"]

  subnet_id      = local.tamnoon_subnet_object["private"][each.key]["id"]
  route_table_id = local.tamnoon_route_table_object["private"][each.key]["id"]
}

resource "aws_route" "tamnoon_private_subnet_to_nat_gateway" {
  for_each = local.tamnoon_subnet["private"]

  route_table_id         = local.tamnoon_route_table_object["private"][each.key]["id"]
  destination_cidr_block = local.cidr["all"]
  nat_gateway_id         = local.tamnoon_nat_gateway_object[each.key]["id"]
}
