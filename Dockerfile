# FROM golang:1.21-alpine AS builder

# WORKDIR /app
# COPY . .
# COPY .env .

# RUN CGO_ENABLED=0 go build -ldflags="-s -w" -o myapp .
# RUN /sbin/apk add --no-cache ca-certificates

# FROM golang:1.21-alpine

# WORKDIR /app
# COPY --from=builder /app/myapp .
# COPY --from=builder /app/.env .

# EXPOSE 8080

# CMD ["./myapp"]

# Build stage
FROM golang:1.21-alpine AS builder

WORKDIR /app

# Copy source code and environment file
COPY . .
COPY .env .

# Build the Go binary
RUN CGO_ENABLED=0 go build -ldflags="-s -w" -o myapp .

# Final stage
FROM alpine:latest

WORKDIR /app

# Copy the built binary and environment file from the builder stage
COPY --from=builder /app/myapp .
COPY --from=builder /app/.env .

EXPOSE 8080

# Command to run the executable
CMD ["./myapp"]

