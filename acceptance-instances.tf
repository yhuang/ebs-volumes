data "aws_ami" "amazon_linux_2" {
  most_recent = true

  filter {
    name = "owner-alias"
    values = [
      "amazon"
    ]
  }

  filter {
    name = "name"
    values = [
      "amzn2-ami-hvm*"
    ]
  }
}

resource "aws_key_pair" "acloud_guru" {
  key_name   = "acloud-guru"
  public_key = local.aws_ec2_public_key
}

resource "aws_instance" "acceptance" {
  for_each = local.subnet_type_set

  ami           = local.instance["image"]
  instance_type = local.instance["instance-type"]

  key_name  = local.key_pair_name
  subnet_id = local.instance["subnet"][each.value]
  tenancy   = "default"

  associate_public_ip_address = each.value == "public" ? true : false

  vpc_security_group_ids = local.instance["network-security-rules"]

  tags = {
    Name = "${local.instance["name"]}-${each.value}"
  }

  root_block_device {
    tags = {
      Name = "${local.instance["name"]}-${each.value}"
    }
  }
}