FROM golang:1.20 AS builder
# Initialize and tidy Go module dependencies
RUN go mod init wordsmith
COPY . /app
WORKDIR /app
EXPOSE 80
# Keep the container running for inspection
CMD ["./wordsmith"]
