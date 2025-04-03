package models

import (
	"github.com/go-playground/validator/v10"
	"reflect"
	"regexp"
)

func GenerationTagValidator(fl validator.FieldLevel) bool {
	switch v := fl.Field(); v.Kind() {
	case reflect.String:
		value := v.String()
		return regexp.
			MustCompile("^generation-(i|ii|iii|iv|v|vi|vii|viii|ix)$").
			MatchString(value)
	default:
		return false
	}
}
