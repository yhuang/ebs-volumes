# resource "aws_ebs_encryption_by_default" "tamnoon" {
#   enabled = true

#   depends_on = [
#     aws_ebs_volume.tamnoon_public,
#     aws_ebs_volume.tamnoon_private,
#     aws_ebs_volume.tamnoon_multi_attach,
#     aws_instance.tamnoon_public,
#     aws_instance.tamnoon_private,
#   ]
# }

resource "aws_ebs_volume" "tamnoon_public" {
  availability_zone = local.instance_input["availability-zone"]
  size              = 16
  iops              = 3000
  type              = "gp3"

  tags = {
    Name = "${local.instance_input["name"]}-public"
  }
}

resource "aws_ebs_volume" "tamnoon_private" {
  availability_zone = local.instance_input["availability-zone"]
  size              = 16
  iops              = 3000
  type              = "gp3"

  tags = {
    Name = "${local.instance_input["name"]}-private"
  }
}

resource "aws_ebs_volume" "tamnoon_multi_attach" {
  availability_zone = local.instance_input["availability-zone"]
  size              = 16
  iops              = 600
  type              = "io1"

  multi_attach_enabled = true

  tags = {
    Name = "${local.instance_input["name"]}-multi-attach"
  }
}

resource "aws_volume_attachment" "tamnoon_public" {
  device_name = local.instance_input["device-name"]
  volume_id   = local.volume_object["public"]
  instance_id = local.instance_object["public"]
}

resource "aws_volume_attachment" "tamnoon_private" {
  device_name = local.instance_input["device-name"]
  volume_id   = local.volume_object["private"]
  instance_id = local.instance_object["private"]
}

resource "aws_volume_attachment" "tamnoon_multi_attach_public" {
  device_name = local.instance_input["multi-device-name"]
  volume_id   = local.volume_object["multi-attach"]
  instance_id = local.instance_object["public"]
}

resource "aws_volume_attachment" "tamnoon_multi_attach_private" {
  device_name = local.instance_input["multi-device-name"]
  volume_id   = local.volume_object["multi-attach"]
  instance_id = local.instance_object["private"]
}