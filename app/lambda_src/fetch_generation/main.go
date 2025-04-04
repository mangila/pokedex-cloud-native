package main

import (
	"encoding/json"
	"errors"
	"fmt"
	"github.com/aws/aws-lambda-go/lambda"
	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/session"
	"github.com/aws/aws-sdk-go/service/sqs"
	"github.com/go-playground/validator/v10"
	"log"
	"os"
	"pokedex/shared/models"
	"pokedex/shared/pokeapi"
)

type Response struct {
	MessageIds []string `json:"message_ids"`
	Count      int      `json:"count"`
}

// Handler function - fetches all Pokemons by Generation and push to SQS queue
func Handler(event json.RawMessage) (Response, error) {
	queueUrl, exist := os.LookupEnv("GENERATION_QUEUE_URL")
	if !exist {
		return Response{}, errors.New("GENERATION_QUEUE_URL environment variable not set")
	}
	var generation models.Generation
	if err := json.Unmarshal(event, &generation); err != nil {
		log.Printf("Failed to unmarshal event: %v", err)
		return Response{}, err
	}
	validate := validator.New(validator.WithRequiredStructEnabled())
	_ = validate.RegisterValidation("generation", models.GenerationTagValidator, true)
	err := validate.Struct(&generation)
	if err != nil {
		return Response{}, fmt.Errorf("not a valid generation: %v", generation.Name)
	}
	response, err := pokeapi.New().FetchByGeneration(generation)
	if err != nil {
		log.Printf("Failed to fetch by generation: %v", err)
		return Response{}, err
	}

	sqsClient := sqs.New(session.Must(session.NewSession()))
	messagesSent := make([]string, 0)
	delaySecondsMaxLimit := int64(900)
	for index, species := range response.PokemonSpecies {
		delaySeconds := int64(index * 3)
		if delaySeconds >= delaySecondsMaxLimit {
			delaySeconds = delaySecondsMaxLimit
		}
		message, err := sqsClient.SendMessage(&sqs.SendMessageInput{
			DelaySeconds: &delaySeconds,
			MessageAttributes: map[string]*sqs.MessageAttributeValue{
				"Name": {
					DataType:    aws.String("String"),
					StringValue: aws.String(species.Name),
				},
				"Url": {
					DataType:    aws.String("String"),
					StringValue: aws.String(species.Url),
				},
			},
			MessageBody: aws.String(fmt.Sprintf("%v -- %v", generation.Name, species.Name)),
			QueueUrl:    &queueUrl,
		})
		if err != nil {
			return Response{}, err
		}
		messagesSent = append(messagesSent, *message.MessageId)
	}

	return Response{
		MessageIds: messagesSent,
		Count:      len(messagesSent),
	}, nil
}

func main() {
	lambda.Start(Handler)
}
