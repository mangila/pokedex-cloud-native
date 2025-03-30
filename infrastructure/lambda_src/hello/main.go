package main

import (
	"context"
	"encoding/json"
	"fmt"
	"github.com/aws/aws-lambda-go/lambda"
)

// Handler function
func Handler(ctx context.Context, event json.RawMessage) (string, error) {
	fmt.Println("Received event:", event)
	return "Hello from Go Lambda -- ASDF!!!", nil
}

func main() {
	lambda.Start(Handler)
}
