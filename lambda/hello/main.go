package main

import (
	"context"
	"fmt"
	"github.com/aws/aws-lambda-go/lambda"
	"shared/models"
)

// Handler function
func Handler(ctx context.Context, event models.Greeting) (string, error) {
	fmt.Println("Received event:", event)
	return "Hello from Go Lambda!", nil
}

func main() {
	lambda.Start(Handler)
}
