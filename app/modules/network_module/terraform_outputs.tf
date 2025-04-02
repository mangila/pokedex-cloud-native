output "pokedex_vpc" {
  value = aws_vpc.pokedex_vpc
}

output "pokedex_subnet" {
  value = aws_subnet.pokedex_subnet
}

output "pokeapi_security_group" {
  value = aws_security_group.pokeapi_security_group
}

output "pokeapi_media_security_group" {
  value = aws_security_group.pokeapi_media_security_group
}