/**
   TODO: internal access stuff
   TODO: terraform modules
 */

resource "aws_vpc" "pokedex_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "pokedex_subnet" {
  vpc_id     = aws_vpc.pokedex_vpc.id
  cidr_block = "10.0.1.0/24"
}

resource "aws_internet_gateway" "pokedex_internet_gateway" {
  vpc_id = aws_vpc.pokedex_vpc.id
}

resource "aws_route_table" "pokedex_route_table" {
  vpc_id = aws_vpc.pokedex_vpc.id
}

resource "aws_route" "internet_access" {
  route_table_id         = aws_route_table.pokedex_route_table.id
  gateway_id             = aws_internet_gateway.pokedex_internet_gateway.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route_table_association" "pokedex_route_table_association" {
  subnet_id      = aws_subnet.pokedex_subnet.id
  route_table_id = aws_route_table.pokedex_route_table.id
}

resource "aws_network_acl" "pokedex_network_acl" {
  vpc_id = aws_vpc.pokedex_vpc.id
}

resource "aws_network_acl_association" "pokedex_network_acl_association" {
  subnet_id      = aws_subnet.pokedex_subnet.id
  network_acl_id = aws_network_acl.pokedex_network_acl.id
}

resource "aws_network_acl_rule" "pokeapi_acl_rule_https_egress" {
  count          = length(local.pokeapi_ip_addresses)
  network_acl_id = aws_network_acl.pokedex_network_acl.id
  rule_number    = count.index + 100
  egress         = true
  protocol       = "tcp"
  from_port      = 443
  to_port        = 443
  rule_action    = "allow"
  cidr_block     = local.pokeapi_ip_addresses[count.index]
}

resource "aws_network_acl_rule" "pokeapi_media_acl_rule_https_egress" {
  count          = length(local.pokeapi_media_ip_addresses)
  network_acl_id = aws_network_acl.pokedex_network_acl.id
  rule_number    = count.index + 200
  egress         = true
  protocol       = "tcp"
  from_port      = 443
  to_port        = 443
  rule_action    = "allow"
  cidr_block     = local.pokeapi_media_ip_addresses[count.index]
}

resource "aws_security_group" "pokeapi_sg" {
  description = "PokeAPI access security group"
  vpc_id      = aws_vpc.pokedex_vpc.id
  name        = "PokeAPI access Security Group"
}

resource "aws_vpc_security_group_egress_rule" "pokeapi_sg_rule_https_egress" {
  count             = length(local.pokeapi_ip_addresses)
  security_group_id = aws_security_group.pokeapi_sg.id
  ip_protocol       = "tcp"
  from_port         = 443
  to_port           = 443
  cidr_ipv4         = local.pokeapi_ip_addresses[count.index]
}

resource "aws_security_group" "pokeapi_media_sg" {
  description = "PokeAPI media access security group"
  vpc_id      = aws_vpc.pokedex_vpc.id
  name        = "PokeAPI media access Security Group"
}

resource "aws_vpc_security_group_egress_rule" "pokeapi_media_sg_rule_https_egress" {
  count             = length(local.pokeapi_media_ip_addresses)
  security_group_id = aws_security_group.pokeapi_media_sg.id
  ip_protocol       = "tcp"
  from_port         = 443
  to_port           = 443
  cidr_ipv4         = local.pokeapi_media_ip_addresses[count.index]
}
