package main

import (
	"context"
	"log"
	"net/http"
	"os"

	"github.com/carlmjohnson/requests"
	"github.com/joho/godotenv"
	"github.com/labstack/echo"
	"github.com/labstack/echo/middleware"
)

func main() {
	e := echo.New()

	e.Use(middleware.CORSWithConfig(middleware.CORSConfig{
		AllowOrigins: []string{"*"},
		AllowHeaders: []string{
			echo.HeaderOrigin,
			echo.HeaderContentType,
			echo.HeaderAccept,
		},
	}))

	e.GET("/", func(c echo.Context) error {
		return c.JSON(http.StatusOK, map[string]interface{}{
			"test": os.Getenv("WORD"),
		})
	})

	e.GET("/test", func(c echo.Context) error {
		var response string
		if err := requests.
			URL("https://test-3mf2w4ufma-uc.a.run.app").
			ToString(&response).
			Fetch(context.Background());
		err != nil {
			return c.JSON(echo.ErrBadRequest.Code, err.Error())
		}

		return c.JSON(http.StatusOK, response)
	})

	e.Start(":8000")
}

func init() {
	err := godotenv.Load()
	if err != nil {
		log.Fatal("Error loading .env file")
	}
}