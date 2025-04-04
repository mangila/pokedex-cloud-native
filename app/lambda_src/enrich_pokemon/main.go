package main

import (
	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-lambda-go/lambda"
)

type Response struct {
	Message string
}

// Handler function - enrich sqs event with Pokemon data from PokeApi
func Handler(event events.SQSMessage) (Response, error) {
	return Response{
		Message: event.Body,
	}, nil
}

func main() {
	lambda.Start(Handler)
}
