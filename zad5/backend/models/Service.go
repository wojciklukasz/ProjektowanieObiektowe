package models

import "gorm.io/gorm"

type Service struct {
	gorm.Model
	Name  string
	Price float32
}
