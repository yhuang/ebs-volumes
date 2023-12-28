resource "aws_ebs_volume" "acceptance" {
  for_each = local.acceptance_instance_set

  availability_zone = each.availability_zone
  size              = 16
}