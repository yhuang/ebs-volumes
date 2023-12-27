resource "aws_subnet" "tamnoon_public" {
  for_each = local.tamnoon_subnet["public"]

  availability_zone = each.key
  vpc_id            = local.tamnoon_vpc_id
  cidr_block        = each.value["cidr-block"]

  tags = {
    Name = each.value["name"]
  }
}

resource "aws_route_table" "tamnoon_public_subnet" {
  vpc_id = local.tamnoon_vpc_id

  tags = {
    Name = local.tamnoon_route_table["public"]["name"]
  }
}

resource "aws_route_table_association" "tamnoon_public_subnet" {
  for_each = local.tamnoon_subnet["public"]

  subnet_id      = local.tamnoon_subnet_object["public"][each.key]["id"]
  route_table_id = local.tamnoon_route_table_object["public"]["id"]
}

resource "aws_route" "tamnoon_public_subnet_to_internet_gateway" {
  route_table_id         = local.tamnoon_route_table_object["public"]["id"]
  destination_cidr_block = local.cidr["all"]
  gateway_id             = local.tamnoon_internet_gateway_id
}
