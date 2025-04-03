package models

import (
	"github.com/go-playground/validator/v10"
	"testing"
)

func TestGenerationValidator(t *testing.T) {
	validate := validator.New(validator.WithRequiredStructEnabled())
	_ = validate.RegisterValidation("generation", GenerationTagValidator, true)
	validGenerations := []Generation{
		{Name: "generation-i"},
		{Name: "generation-ii"},
		{Name: "generation-iii"},
		{Name: "generation-iv"},
		{Name: "generation-v"},
		{Name: "generation-vi"},
		{Name: "generation-vii"},
		{Name: "generation-viii"},
		{Name: "generation-ix"},
	}

	for _, generation := range validGenerations {
		err := validate.Struct(&generation)
		if err != nil {
			t.Errorf("Error in generation: %v", err)
		}
	}
}

func TestGenerationValidatorFail(t *testing.T) {
	validate := validator.New(validator.WithRequiredStructEnabled())
	_ = validate.RegisterValidation("generation", GenerationTagValidator, true)
	validGenerations := []Generation{
		{Name: ""},
		{Name: "hello world"},
		{Name: "generation-k"},
	}

	for _, generation := range validGenerations {
		err := validate.Struct(&generation)
		if err == nil {
			t.Errorf("Error in generation: %v", err)
		}
	}
}
