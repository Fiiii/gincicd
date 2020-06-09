FROM golang:alpine AS  builder

RUN apk update && apk add --no-cache git

RUN mkdir /app
ADD . /app
WORKDIR /app
RUN go get -d -v
RUN go build -o fiicicd

FROM golang:alpine

COPY --from=builder /app/fiicicd /

EXPOSE 8080

ENTRYPOINT ["/fiicicd"]