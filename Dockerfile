# Dockerfile
FROM golang:1.23-alpine AS builder

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . .
RUN go build -o familyemo ./cmd

FROM alpine:latest

WORKDIR /root/
COPY --from=builder /app/familyemo .

COPY configs/config.yml /root/configs/config.yml
COPY .env /root/.env

EXPOSE 8000

CMD ["./familyemo"]