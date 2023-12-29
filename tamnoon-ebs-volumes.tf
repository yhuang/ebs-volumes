resource "aws_ebs_volume" "tamnoon_public" {
  availability_zone = local.availability_zone_list[0]
  size              = 16

  tags = {
    Name = "${local.instance_input["name"]}-public"
  }
}

resource "aws_volume_attachment" "tamnoon_public" {
  device_name = local.instance_input["device-name"]
  volume_id   = local.volume_object["public"]
  instance_id = local.instance_object["public"]
}

resource "aws_ebs_volume" "tamnoon_private" {
  availability_zone = local.availability_zone_list[1]
  size              = 16

  tags = {
    Name = "${local.instance_input["name"]}-private"
  }
}

resource "aws_volume_attachment" "tamnoon_private" {
  device_name = local.instance_input["device-name"]
  volume_id   = local.volume_object["private"]
  instance_id = local.instance_object["private"]
}