FROM golang:latest as builder

WORKDIR /build
COPY . /build/

# Installing custom packages from github
RUN go get -d github.com/prometheus/client_golang/prometheus/promhttp
RUN CGO_ENABLED=0 go build -a -installsuffix cgo --ldflags "-s -w" -o /build/main

FROM alpine:3.9.4
LABEL app="go-fii"
LABEL environment="production"
WORKDIR /app
RUN adduser -S -D -H -h /app appuser
USER appuser

# Add artifact from builder stage
COPY --from=builder /build/main /app/

# Expose port to host
EXPOSE 8080

# Run software with any arguments
ENTRYPOINT ["./main"]