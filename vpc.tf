resource "aws_vpc" "tamnoon" {
  cidr_block       = local.cidr["tamnoon-vpc"]
  instance_tenancy = local.tamnoon_vpc["instance-tenancy"]

  tags = {
    Name = local.tamnoon_vpc["name"]
  }
}
