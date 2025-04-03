package main

import (
	"context"
	"encoding/json"
	"fmt"
	"github.com/aws/aws-lambda-go/lambda"
	"github.com/go-playground/validator/v10"
	"log"
	"pokedex/shared/models"
	"pokedex/shared/pokeapi"
)

// Handler function - fetches all Pokemons by Generation and push to SQS queue
func Handler(ctx context.Context, event json.RawMessage) (*models.GenerationResponse, error) {
	var generation models.Generation
	if err := json.Unmarshal(event, &generation); err != nil {
		log.Printf("Failed to unmarshal event: %v", err)
		return nil, err
	}
	validate := validator.New(validator.WithRequiredStructEnabled())
	_ = validate.RegisterValidation("generation", models.GenerationTagValidator, true)
	err := validate.Struct(&generation)
	if err != nil {
		return nil, fmt.Errorf("not a valid generation: %v", generation.Name)
	}
	response, err := pokeapi.New().FetchByGeneration(generation)
	if err != nil {
		log.Printf("Failed to fetch by generation: %v", err)
		return nil, err
	}
	log.Printf("Fetched by generation: %v", response)
	log.Printf("Success -- %s", generation.Name)
	return response, nil
}

func main() {
	lambda.Start(Handler)
}
