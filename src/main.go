// Sample run-helloworld is a minimal Cloud Run service.
package main

import (
	"fmt"
	"io"
	"log"
	"net/http"
	"os"

	"github.com/sirupsen/logrus"
	logrusadapter "logur.dev/adapter/logrus"
	"logur.dev/logur"
)

const (
	exitError      = 1
	exitUnexpected = 125
)

const (
	appName = "hello-service"
)

func main() {
	defer func() {
		if err := recover(); err != nil {
			fmt.Fprintf(os.Stderr, "%s\n", err)
			os.Exit(exitUnexpected)
		}
	}()
	if err := run(os.Args, os.Stdin, os.Stdout); err != nil {
		fmt.Fprintf(os.Stderr, "%s\n", err)
		os.Exit(exitError)
	}
}

func NewSimpleLogger() logur.LoggerFacade {
	logger := logrus.New()

	logger.SetOutput(os.Stdout)
	logger.SetFormatter(&logrus.JSONFormatter{})
	logger.SetLevel(logrus.InfoLevel)

	return logrusadapter.New(logger)
}

func run(args []string, _ io.Reader, _ io.Writer) error {

	logger := NewSimpleLogger()
	log.SetOutput(logur.NewLevelWriter(logger, logur.Info))
	logger.Info("starting app", map[string]interface{}{
		"name": appName,
	})

	// Attach handler
	http.HandleFunc("/", handler)

	// Determine port for HTTP service.
	port := os.Getenv("PORT")
	if port == "" {
		port = "8080"
	}

	// Start HTTP server.
	logger.Info("start serving", map[string]interface{}{
		"port": port,
	})
	if err := http.ListenAndServe(":"+port, nil); err != nil {
		return err
	}

	return nil
}

func handler(w http.ResponseWriter, r *http.Request) {
	name := os.Getenv("NAME")
	if name == "" {
		name = "World"
	}
	fmt.Fprintf(w, "Hello %s!\n", name)
}
