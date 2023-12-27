locals {
  # localize input variables
  asn                = var.asn
  cidr               = var.cidr
  aws_ec2_public_key = var.aws_ec2_public_key


  tamnoon_vpc = {
    "instance-tenancy"      = "default"
    "internet-gateway-name" = "tamnoon-internet-gateway"
    "name"                  = "tamnoon-vpc"
  }

  tamnoon_vpc_id = aws_vpc.tamnoon.id

  region = "us-west-2"
  availability_zone_list = [
    for letter in ["a", "b"] : "${local.region}${letter}"
  ]

  key_pair_name = aws_key_pair.acloud_guru.id

  subnet_type_list = [
    "public",
    "private",
  ]

  subnet_type_set = toset(local.subnet_type_list)

  instance = {
    "name" = "acceptance-test"

    "image" = data.aws_ami.amazon_linux_2.id

    "instance-type" = "t2.micro"

    "subnet" = {
      for t in local.subnet_type_list : t => local.tamnoon_subnet_object[t][local.availability_zone_list[0]]["id"]
    }

    "network-security-rules" = [
      for k, v in local.tamnoon_security_group : v
    ]
  }

  tamnoon_subnet = {
    for i, t in local.subnet_type_list : t => {
      for j, az in local.availability_zone_list : az => {
        "name"              = "tamnoon-${t}-subnet-${az}"
        "availability-zone" = az
        "cidr-block"        = local.subnet_cidr_list[i * 2 + j]
      }
    }
  }

  subnet_cidr_list = cidrsubnets(local.cidr["tamnoon-vpc"], 2, 2, 2, 2)

  tamnoon_subnet_object = {
    "public" = {
      for az in local.availability_zone_list : az => {
        "id" = aws_subnet.tamnoon_public[az].id
      }
    }

    "private" = {
      for az in local.availability_zone_list : az => {
        "id" = aws_subnet.tamnoon_private[az].id
      }
    }
  }

  tamnoon_route_table = {
    "public" = {
      "name" = "tamnoon-public-subnet-route-table"
    }

    "private" = {
      for az in local.availability_zone_list : az => {
        "name" = "tamnoon-private-subnet-${az}-route-table"
      }
    }
  }

  tamnoon_route_table_object = {
    "public" = {
      "id" = aws_route_table.tamnoon_public_subnet.id
    }

    "private" = {
      for az in local.availability_zone_list : az => {
        "id" = aws_route_table.tamnoon_private_subnet[az].id
      }
    }
  }

  tamnoon_internet_gateway_id = aws_internet_gateway.tamnoon.id

  tamnoon_nat_gateway = {
    for az in local.availability_zone_list : az => {
      "name" = "tamnoon-public-nat-gateway-${az}"
      "ip"   = aws_eip.tamnoon_public_nat_gateway[az].id
    }
  }

  tamnoon_nat_gateway_object = {
    for az in local.availability_zone_list : az => {
      "id" = aws_nat_gateway.tamnoon_public[az].id
      "ip" = aws_eip.tamnoon_public_nat_gateway[az].id
    }
  }

  tamnoon_nat_gateway_id = {
    for az in local.availability_zone_list : az => local.tamnoon_nat_gateway_object[az]["id"]
  }

  tamnoon_transit_gateway = {
    "name" = "tamnoon-transit-gateway"
  }

  tamnoon_transit_gateway_attachment_name = {
    "tamnoon-vpc" = "${local.tamnoon_vpc["name"]}-attachment"
  }

  tamnoon_transit_gateway_id = aws_ec2_transit_gateway.tamnoon.id

  tamnoon_security_group = {
    "i--tamnoon-vpc--to--tamnoon-vpc" = aws_security_group.i_tamnoon_vpc_to_tamnoon_vpc.id
    "e--tamnoon-vpc--to--all"         = aws_security_group.e_tamnoon_vpc_to_all.id
    "i--home--to--tamnoon-vpc"        = aws_security_group.i_home_to_tamnoon_vpc.id
  }
}
