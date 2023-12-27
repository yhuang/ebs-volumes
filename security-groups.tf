resource "aws_security_group" "i_tamnoon_vpc_to_tamnoon_vpc" {
  name   = "i--tamnoon-vpc--to--tamnoon-vpc"
  vpc_id = local.tamnoon_vpc_id

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = [
      local.cidr["tamnoon-vpc"],
    ]
  }

  tags = {
    Name = "i--tamnoon-vpc--to--tamnoon-vpc"
  }
}

resource "aws_security_group" "i_home_to_tamnoon_vpc" {
  name   = "i--home--to--tamnoon-vpc"
  vpc_id = local.tamnoon_vpc_id

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = [
      local.cidr["home"],
    ]
  }

  ingress {
    from_port = -1
    to_port   = -1
    protocol  = "icmp"
    cidr_blocks = [
      local.cidr["home"],
    ]
  }

  tags = {
    Name = "i--home--to--tamnoon-vpc"
  }
}

resource "aws_security_group" "e_tamnoon_vpc_to_all" {
  name   = "e--tamnoon-vpc--to--all"
  vpc_id = local.tamnoon_vpc_id

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = [
      local.cidr["all"],
    ]
  }

  tags = {
    Name = "e--tamnoon-vpc--to--all"
  }
}
