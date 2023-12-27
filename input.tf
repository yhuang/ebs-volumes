variable "asn" {
  type = map(number)
}

variable "cidr" {
  type = map(string)
}

variable "aws_ec2_public_key" {
  type = string
}

variable "tfc_hostname" {
  type = string
}

variable "tfc_organization_name" {
  type = string
}