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

resource "aws_instance" "tamnoon_public" {
  ami           = local.instance_input["image"]
  instance_type = local.instance_input["instance-type"]

  key_name  = local.key_pair_name
  subnet_id = local.tamnoon_subnet_object["public"]["us-west-2a"]["id"]
  tenancy   = "default"

  associate_public_ip_address = true

  vpc_security_group_ids = local.instance_input["network-security-rules"]

  tags = {
    Name = "${local.instance_input["name"]}-public"
  }

  root_block_device {
    tags = {
      Name = "${local.instance_input["name"]}-public"
    }
  }
}

resource "aws_instance" "tamnoon_private" {
  ami           = local.instance_input["image"]
  instance_type = local.instance_input["instance-type"]

  key_name  = local.key_pair_name
  subnet_id = local.tamnoon_subnet_object["private"]["us-west-2b"]["id"]
  tenancy   = "default"

  associate_public_ip_address = false

  vpc_security_group_ids = local.instance_input["network-security-rules"]

  tags = {
    Name = "${local.instance_input["name"]}-private"
  }

  root_block_device {
    tags = {
      Name = "${local.instance_input["name"]}-private"
    }
  }
}