package models

// Generation - e.g "generation-i"
type Generation struct {
	Name string `json:"name"`
}

// GenerationResponse - https://pokeapi.co/api/v2/generation/<Generation.Name>
type GenerationResponse struct {
	PokemonSpecies []struct {
		Name string `json:"name"`
		Url  string `json:"url"`
	} `json:"pokemon_species"`
}
