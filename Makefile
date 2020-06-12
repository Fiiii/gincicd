GOFILES = $(shell find . -name '*.go')

default: build

workdir:
	mkdir -p workdir

build: workdir/pingapp

build-native: $(GOFILES)
	go build -o workdir/native-pingapp .

workdir/pingapp: $(GOFILES)
	GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build -o workdir/pingapp .