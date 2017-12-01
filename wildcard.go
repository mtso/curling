package main

import (
	"log"
	"net/http"
	"os"

	"github.com/gorilla/mux"
)

func makeRouter() (router *mux.Router) {
	router = mux.NewRouter()
	router.HandleFunc("/files/{path:.*}", getHandler).Methods("GET")
	router.HandleFunc("/files/{path:.*}", postHandler).Methods("POST")
	return
}

func main() {
	port := os.Getenv("PORT")
	if port == "" {
		port = "3000"
	}
	log.Fatal(http.ListenAndServe(":"+port, makeRouter()))
}

func getHandler(w http.ResponseWriter, r *http.Request) {
	w.Write([]byte("[GET] " + mux.Vars(r)["path"]))
}

func postHandler(w http.ResponseWriter, r *http.Request) {
	w.Write([]byte("[POST] " + mux.Vars(r)["path"]))
}
