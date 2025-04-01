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