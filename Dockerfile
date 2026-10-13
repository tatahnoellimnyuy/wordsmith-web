FROM golang:1.20 AS builder
COPY . /app
WORKDIR /app
RUN go mod init
RUN CGO_ENABLED=0 GOOS=linux go build -v -o wordsmith .
EXPOSE 80
# Keep the container running for inspection
CMD ["./wordsmith"]
