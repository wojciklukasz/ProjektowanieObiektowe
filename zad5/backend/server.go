package main

import (
	"cw5back/database"
	"cw5back/routes"
	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
	"net/http"
)

func main() {
	database.Connect()

	e := echo.New()

	e.Use(middleware.CORSWithConfig(middleware.CORSConfig{
		AllowOrigins: []string{"http://localhost:3000"},
		AllowHeaders: []string{echo.HeaderOrigin, echo.HeaderContentType, echo.HeaderAccept},
	}))

	e.GET("/", func(c echo.Context) error {
		return c.String(http.StatusOK, "Hello, World!")
	})

	e.GET("/service/", routes.GetServices)
	e.GET("/service/:id", routes.GetService)
	e.POST("/service/", routes.SaveService)

	e.POST("/payment/", routes.ProcessPayment)

	e.Logger.Fatal(e.Start(":8000"))
}
