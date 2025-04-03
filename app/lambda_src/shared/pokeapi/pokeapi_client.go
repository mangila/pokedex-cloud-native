package pokeapi

import (
	"fmt"
	"github.com/go-resty/resty/v2"
	"pokedex/shared/models"
	"time"
)

type PokeApi struct {
	http *resty.Client
}

func New() *PokeApi {
	restyClient := resty.New()
	restyClient.
		SetBaseURL("https://pokeapi.co/api/v2").
		SetTimeout(30 * time.Second).
		SetRetryCount(3).                      // Number of retry attempts
		SetRetryWaitTime(2 * time.Second).     // Wait time between retries
		SetRetryMaxWaitTime(10 * time.Second). // Maximum total wait time
		AddRetryCondition(func(response *resty.Response, err error) bool {
			// Retry only for specific cases, e.g., HTTP status 5xx or network errors
			return err != nil || response.StatusCode() >= 500
		})
	return &PokeApi{
		http: restyClient,
	}
}

func (client *PokeApi) FetchByGeneration(generation models.Generation) (*models.GenerationResponse, error) {
	httpResponse, err := client.http.R().
		SetResult(&models.GenerationResponse{}).
		Get(fmt.Sprintf("generation/%s", generation.Name))
	if err != nil {
		return nil, err
	}
	if httpResponse.IsError() {
		return nil, fmt.Errorf("failed to fetch by generation(%v): %v", generation.Name, httpResponse.String())
	}

	return httpResponse.Result().(*models.GenerationResponse), nil
}
