package pokeapi

import (
	"pokedex/shared/models"
	"strings"
	"testing"
)

func TestPokeApi_FetchByGeneration_404(t *testing.T) {
	t.Skip("Only for Local testing")
	client := New()
	_, err := client.FetchByGeneration(models.Generation{
		Name: "generation-not-exists",
	})
	if err != nil {
		strings.Contains("Not Found", err.Error())
	} else {
		t.Errorf("Should return error 404 Not Found")
	}
}

func TestPokeApi_FetchByGeneration(t *testing.T) {
	t.Skip("Only for Local testing")
	client := New()
	response, err := client.FetchByGeneration(models.Generation{
		Name: "generation-i",
	})
	if err != nil {
		t.Errorf("Should not return error %v", err)
	}
	if len(response.PokemonSpecies) < 1 {
		t.Errorf("Should return a list greater than zero")
	}
}
