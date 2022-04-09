package main

// zrobic jeden endpoint, ktory bedzie wywolywal inna strone (np. pogoda)
// pobrac jsonem (api), przeparsowac i wyswietlic

import (
	"io"
	"net/http"
	"github.com/labstack/echo/v4"
	"fmt"
)

func proxy() string {
	resp, err := http.Get("https://api.openweathermap.org/data/2.5/weather?lat=50.0833&lon=19.9167&appid=f38475d9a54f1988597db701d1089efc")
	if err != nil {
		fmt.Println("GET Error!")
	}
	defer resp.Body.Close()
	body, err := io.ReadAll(resp.Body)
	return string(body)
}

func main() {
	e := echo.New()
	e.GET("/", func(c echo.Context) error {
		r := proxy()
		// return c.String(http.StatusOK, r)
		return c.JSON(http.StatusOK, r)
	})
	e.Logger.Fatal(e.Start(":1323"))
}
