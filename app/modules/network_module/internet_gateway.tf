resource "aws_internet_gateway" "pokedex_internet_gateway" {
  vpc_id = aws_vpc.pokedex_vpc.id
}