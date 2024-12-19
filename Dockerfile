FROM golang:1.20 AS builder
COPY . /app
WORKDIR /app
EXPOSE 80
# Keep the container running for inspection
CMD ["./wordsmith"]
