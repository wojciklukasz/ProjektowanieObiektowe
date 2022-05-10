package routes

import (
	"cw5back/database"
	"cw5back/models"
	"github.com/labstack/echo/v4"
	"net/http"
)

func GetServices(c echo.Context) error {
	var services []models.Service

	result := database.Database.Find(&services)
	if result.Error != nil {
		return c.String(http.StatusNotFound, "Items not found")
	}

	return c.JSON(http.StatusOK, services)
}

func GetService(c echo.Context) error {
	id := c.Param("id")
	var service models.Service

	result := database.Database.Find(&service, id)
	if result.Error != nil {
		return c.String(http.StatusNotFound, "Item not found")
	}

	return c.JSON(http.StatusOK, service)
}

func SaveService(c echo.Context) error {
	service := new(models.Service)

	err := c.Bind(service)
	if err != nil {
		return c.String(http.StatusBadRequest, "Invalid body "+err.Error())
	}

	result := database.Database.Create(service)
	if result.Error != nil {
		return c.String(http.StatusBadRequest, "Database error "+result.Error.Error())
	}

	return c.JSON(http.StatusOK, service)
}
