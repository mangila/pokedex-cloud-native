package main

import (
	"context"
	"encoding/json"
	"github.com/aws/aws-lambda-go/lambda"
	"log"
	"os"
	"shared/models"
	"shared/pokeapi"
)

// Handler function - fetches all Pokemons by Generation and push to SQS queue
func Handler(ctx context.Context, event json.RawMessage) error {
	client := pokeapi.New()
	var generation models.Generation
	if err := json.Unmarshal(event, &generation); err != nil {
		log.Printf("Failed to unmarshal event: %v", err)
		return err
	}

	response, err := client.FetchByGeneration(generation)
	if err != nil {
		log.Printf("Failed to fetch by generation: %v", err)
		return err
	}
	log.Printf("Fetched by generation: %v", response)
	os.Getenv("SQS_QUEUE_URL")
	log.Printf("Success -- %s", generation.Name)
	return nil
}

func main() {
	lambda.Start(Handler)
}
