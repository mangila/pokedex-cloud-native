module pokedex/fetch-generation

go 1.24

require github.com/aws/aws-lambda-go v1.47.0

require (
	github.com/aws/aws-sdk-go v1.55.6
	github.com/go-playground/validator/v10 v10.26.0
	pokedex/shared v0.0.0
)

require (
	github.com/gabriel-vasile/mimetype v1.4.8 // indirect
	github.com/go-playground/locales v0.14.1 // indirect
	github.com/go-playground/universal-translator v0.18.1 // indirect
	github.com/go-resty/resty/v2 v2.16.5 // indirect
	github.com/jmespath/go-jmespath v0.4.0 // indirect
	github.com/leodido/go-urn v1.4.0 // indirect
	golang.org/x/crypto v0.36.0 // indirect
	golang.org/x/net v0.38.0 // indirect
	golang.org/x/sys v0.31.0 // indirect
	golang.org/x/text v0.23.0 // indirect
)

replace pokedex/shared => ../shared
