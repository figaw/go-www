package main

import (
	"fmt"
	"net/http"
	"os"
)

func healthz(w http.ResponseWriter, req *http.Request) {
	fmt.Fprintf(w, "healthy")
}

func hello(w http.ResponseWriter, req *http.Request) {
	fmt.Fprintf(w, "Hello, World!")
}


func main() {

	http.HandleFunc("/healthz", healthz)
	http.HandleFunc("/", hello)

	PORT, ok := os.LookupEnv("PORT")
	if !ok {
		PORT = "8080"
	}

	http.ListenAndServe(fmt.Sprintf(":%s", PORT), nil)
}
