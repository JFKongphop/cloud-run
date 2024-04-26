FROM golang:1.21.5 AS builder

WORKDIR /app
COPY . .

COPY .env .

RUN CGO_ENABLED=0 go build -ldflags="-s -w" -o myapp .

FROM scratch

WORKDIR /app
COPY --from=builder /app/myapp .
COPY --from=builder /app/.env . 

EXPOSE 8080

CMD ["./myapp"]