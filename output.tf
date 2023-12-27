output "region" {
  value = local.region
}

output "availability_zone_list" {
  value = local.availability_zone_list
}

output "tamnoon_vpc_id" {
  value = local.tamnoon_vpc_id
}

output "tamnoon_subnet" {
  value = local.tamnoon_subnet_object
}

output "tamnoon_route_table" {
  value = local.tamnoon_route_table_object
}

output "tamnoon_internet_gateway_id" {
  value = local.tamnoon_internet_gateway_id
}

output "tamnoon_nat_gateway_id" {
  value = local.tamnoon_nat_gateway_id
}

output "tamnoon_security_group" {
  value = local.tamnoon_security_group
}
