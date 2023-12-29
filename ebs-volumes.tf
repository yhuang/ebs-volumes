resource "aws_ebs_volume" "acceptance" {
  for_each = local.availability_zone_set

  availability_zone = each.value
  size              = 16

  tags = {
    Name = "${local.instance["name"]}-${each.value}"
  }
}