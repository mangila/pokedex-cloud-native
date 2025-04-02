resource "aws_network_acl" "pokedex_network_acl" {
  vpc_id = aws_vpc.pokedex_vpc.id
}

resource "aws_network_acl_association" "pokedex_network_acl_association" {
  subnet_id      = aws_subnet.pokedex_subnet.id
  network_acl_id = aws_network_acl.pokedex_network_acl.id
}

resource "aws_network_acl_rule" "pokeapi_acl_rule_https_egress" {
  count          = length(local.pokeapi_address_ranges)
  network_acl_id = aws_network_acl.pokedex_network_acl.id
  rule_number    = count.index + 100
  egress         = true
  protocol       = "tcp"
  from_port      = 443
  to_port        = 443
  rule_action    = "allow"
  cidr_block     = local.pokeapi_address_ranges[count.index]
}

resource "aws_network_acl_rule" "pokeapi_media_acl_rule_https_egress" {
  count          = length(local.pokeapi_media_address_ranges)
  network_acl_id = aws_network_acl.pokedex_network_acl.id
  rule_number    = count.index + 200
  egress         = true
  protocol       = "tcp"
  from_port      = 443
  to_port        = 443
  rule_action    = "allow"
  cidr_block     = local.pokeapi_media_address_ranges[count.index]
}