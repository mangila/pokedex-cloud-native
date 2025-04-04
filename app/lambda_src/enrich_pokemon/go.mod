module pokedex/enrich-pokemon

go 1.24

require github.com/aws/aws-lambda-go v1.47.0

require (
	github.com/aws/aws-sdk-go v1.55.6
	github.com/go-playground/validator/v10 v10.26.0
	pokedex/shared v0.0.0
)

replace pokedex/shared => ../shared