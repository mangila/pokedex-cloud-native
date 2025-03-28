/**
   TODO: internal access stuff
   TODO: terraform modules
 */

resource "aws_vpc" "pokedex_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "pokedex_public_subnet" {
  depends_on = [aws_vpc.pokedex_vpc]
  vpc_id     = aws_vpc.pokedex_vpc.id
  cidr_block = "10.0.1.0/24"
}

resource "aws_internet_gateway" "pokedex_internet_gateway" {
  vpc_id = aws_vpc.pokedex_vpc.id
}

resource "aws_route_table" "pokedex_public_route_table" {
  vpc_id = aws_vpc.pokedex_vpc.id
}

resource "aws_route" "internet_access" {
  route_table_id         = aws_route_table.pokedex_public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.pokedex_internet_gateway.id
}

resource "aws_route_table_association" "route_table_association" {
  subnet_id      = aws_subnet.pokedex_public_subnet.id
  route_table_id = aws_route_table.pokedex_public_route_table.id
}

resource "aws_security_group" "pokedex_public_sg" {
  description = "Public security group"
  depends_on  = [aws_vpc.pokedex_vpc]
  vpc_id      = aws_vpc.pokedex_vpc.id
}

resource "aws_vpc_security_group_egress_rule" "pokedex_public_https_egress" {
  description       = "Public Internet Egress"
  security_group_id = aws_security_group.pokedex_public_sg.id
  ip_protocol       = "tcp"
  from_port         = 443
  to_port           = 443
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_subnet" "pokedex_private_subnet" {
  vpc_id     = aws_vpc.pokedex_vpc.id
  cidr_block = "10.0.2.0/24"
}

resource "aws_security_group" "pokedex_private_sg" {
  description = "Private security group"
  depends_on  = [aws_vpc.pokedex_vpc]
  vpc_id      = aws_vpc.pokedex_vpc.id
}

resource "aws_vpc_security_group_ingress_rule" "pokedex_private_any_ingress" {
  description       = "All inbound internal traffic"
  security_group_id = aws_security_group.pokedex_private_sg.id
  ip_protocol       = -1
  from_port         = 0
  to_port           = 0
  cidr_ipv4         = aws_subnet.pokedex_private_subnet.cidr_block
}

resource "aws_vpc_security_group_egress_rule" "pokedex_private_any_egress" {
  description       = "All outbound internal traffic"
  security_group_id = aws_security_group.pokedex_private_sg.id
  ip_protocol       = -1
  from_port         = 0
  to_port           = 0
  cidr_ipv4         = aws_subnet.pokedex_private_subnet.cidr_block
}