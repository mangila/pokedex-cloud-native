module pokedex/persist-pokemon

go 1.24

require github.com/aws/aws-lambda-go v1.47.0

require (
	github.com/aws/aws-sdk-go v1.55.6 // indirect
	github.com/go-playground/validator/v10 v10.26.0 // indirect
	pokedex/shared v0.0.0 // indirect
)

replace pokedex/shared => ../shared
