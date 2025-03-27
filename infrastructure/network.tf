/**
  ### AWS networking ###
  - VPC
  - public/private subnets
  - security groups
    - public HTTPS
    - private any protocol
 */

resource "aws_vpc" "pokedex_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "pokedex_public_subnet" {
  depends_on = [aws_vpc.pokedex_vpc]
  vpc_id     = aws_vpc.pokedex_vpc.id
  cidr_block = "10.0.1.0/24"
}

resource "aws_security_group" "public_sg" {
  description = "Public security group that allows all traffic"
  depends_on = [aws_vpc.pokedex_vpc]
  vpc_id      = aws_vpc.pokedex_vpc.id
}

resource "aws_vpc_security_group_ingress_rule" "public_https_ingress" {
  description       = "All inbound HTTPS from anywhere"
  security_group_id = aws_security_group.public_sg.id
  ip_protocol       = "tcp"
  from_port         = 443
  to_port           = 443
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_vpc_security_group_egress_rule" "public_https_egress" {
  description       = "All outbound HTTPS from anywhere"
  security_group_id = aws_security_group.public_sg.id
  ip_protocol       = "tcp"
  from_port         = 443
  to_port           = 443
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_subnet" "pokedex_private_subnet" {
  vpc_id     = aws_vpc.pokedex_vpc.id
  cidr_block = "10.0.1.128/24"
}

resource "aws_security_group" "private_sg" {
  description = "Private security group only for the VPC"
  depends_on = [aws_vpc.pokedex_vpc]
  vpc_id      = aws_vpc.pokedex_vpc.id
}

resource "aws_vpc_security_group_ingress_rule" "private_any_ingress" {
  description       = "All inbound internal traffic"
  security_group_id = aws_security_group.private_sg.id
  ip_protocol       = -1
  from_port         = 0
  to_port           = 0
}

resource "aws_vpc_security_group_egress_rule" "private_any_egress" {
  description       = "All outbound internal traffic"
  security_group_id = aws_security_group.private_sg.id
  ip_protocol       = -1
  from_port         = 0
  to_port           = 0
}