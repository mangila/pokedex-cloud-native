package main

import (
	"encoding/json"
	"github.com/aws/aws-lambda-go/lambda"
	"log"
)

type Response struct {
	Message string
}

// Handler function - persist the Pokemon to DynamoDb
func Handler(event json.RawMessage) (Response, error) {
	var response Response
	if err := json.Unmarshal(event, &response); err != nil {
		log.Printf("Failed to unmarshal event: %v", err)
		return Response{}, err
	}
	return response, nil
}

func main() {
	lambda.Start(Handler)
}
