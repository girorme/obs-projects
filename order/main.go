package main

import (
	"net/http"

	"github.com/gin-gonic/gin"
	"go.elastic.co/apm/module/apmgin"
)

func main() {
	engine := gin.New()
	engine.Use(apmgin.Middleware(engine))

	engine.GET("/ping", func(c *gin.Context) {
		c.JSON(http.StatusFound, gin.H{"success": true, "msg": "pong order service"})
	})

	engine.GET("/foo", func(c *gin.Context) {
		c.JSON(http.StatusFound, gin.H{"success": true, "msg": "bar order service"})
	})

	engine.Run(":8081")
}
