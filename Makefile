.DEFAULT_GOAL := build

VERSION=$(shell git describe --tags)

run:
	go run main.go

sum:
	go run main.go sum

build: $(shell find . -name \*.go)
	# use the -s and -w linker flags to strip the debugging information
	go build -ldflags="-s -w" -o build/gitime .

release: build
	upx --ultra-brute build/gitime

test:
	go test `go list ./...`

coverage:
	go test `go list ./...` -coverprofile=coverage.txt -covermode=atomic

install: build
	sudo install build/gitime /usr/local/bin/

install-optimized: build release
	sudo install build/gitime /usr/local/bin/
