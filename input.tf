variable "asn" {
  type = map(number)
}

variable "cidr" {
  type = map(string)
}

variable "pre_shared_keys" {
  type      = list(list(string))
  sensitive = true
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