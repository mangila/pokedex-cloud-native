resource "aws_security_group" "pokeapi_security_group" {
  description = "PokeAPI access security group"
  vpc_id      = aws_vpc.pokedex_vpc.id
  name        = "PokeAPI access Security Group"
}

resource "aws_vpc_security_group_egress_rule" "pokeapi_security_group_rule_https_egress" {
  count             = length(local.pokeapi_address_ranges)
  security_group_id = aws_security_group.pokeapi_security_group.id
  ip_protocol       = "tcp"
  from_port         = 443
  to_port           = 443
  cidr_ipv4         = local.pokeapi_address_ranges[count.index]
}

resource "aws_security_group" "pokeapi_media_security_group" {
  description = "PokeAPI media access security group"
  vpc_id      = aws_vpc.pokedex_vpc.id
  name        = "PokeAPI media access Security Group"
}

resource "aws_vpc_security_group_egress_rule" "pokeapi_media_security_group_rule_https_egress" {
  count             = length(local.pokeapi_media_address_ranges)
  security_group_id = aws_security_group.pokeapi_media_security_group.id
  ip_protocol       = "tcp"
  from_port         = 443
  to_port           = 443
  cidr_ipv4         = local.pokeapi_media_address_ranges[count.index]
}