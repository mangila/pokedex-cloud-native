package main

import (
	"github.com/aws/aws-lambda-go/lambda"
)

func handler() (string, error) {
	return "Hello, Lambda!", nil
}

func main() {
	lambda.Start(handler)
}
