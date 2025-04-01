resource "aws_subnet" "pokedex_subnet" {
  vpc_id     = aws_vpc.pokedex_vpc.id
  cidr_block = "10.0.1.0/24"
}