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

resource "aws_network_acl" "pokedex_network_acl" {
  vpc_id = aws_vpc.pokedex_vpc.id
}

resource "aws_network_acl_association" "example" {
  subnet_id      = aws_subnet.pokedex_public_subnet.id
  network_acl_id = aws_network_acl.pokedex_network_acl.id
}

resource "aws_network_acl_rule" "allow_https_egress" {
  network_acl_id = aws_network_acl.pokedex_network_acl.id
  rule_number    = 100
  egress         = true
  protocol       = "tcp"
  from_port      = 443
  to_port        = 443
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
}

resource "aws_network_acl_rule" "deny_ingress" {
  network_acl_id = aws_network_acl.pokedex_network_acl.id
  rule_action    = "deny"
  egress         = false
  protocol       = "-1"
  cidr_block     = "0.0.0.0/0"
  rule_number    = 100
}