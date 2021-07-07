package main

import (
	"fmt"
	"math/rand"
	"os"
	"time"

	"go.uber.org/zap"
)

const logPath = "/app/logs/crawler.log"

func main() {
	urls := []string{"http://google.com.br", "https://twitter.com"}
	l, err := getLog()
	if err != nil {
		panic(err)
	}

	i := 0
	for {

		i++
		if rand.Intn(10) == 1 {
			l.Error("test error", zap.Error(fmt.Errorf("error because test: %d", i)))
		}

		for _, url := range urls {
			msg := fmt.Sprintf("Crawling %s/%d\n", url, i)
			fmt.Print(msg)
			l.Info(msg, zap.String("application", "crawler"))
			time.Sleep(5 * time.Second)
		}
	}
}

func getLog() (*zap.Logger, error) {
	os.OpenFile(logPath, os.O_RDONLY|os.O_CREATE, 0666)
	c := zap.NewProductionConfig()
	c.OutputPaths = []string{"stdout", logPath}
	l, err := c.Build()

	return l, err
}
