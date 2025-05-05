# Stage 1: Build the Go binary
FROM golang:1.19 AS build

WORKDIR /app

# Copy go mod files first (for better layer caching)
COPY go.mod go.sum ./
RUN go mod download

# Copy source code
COPY . .

# Build the application
RUN go build -o server main.go

# Stage 2: Runtime container
FROM golang:1.19

WORKDIR /app

# Copy built Go binary from the build stage
COPY --from=build /app/server .
# Copy wait-for script
COPY wait-for.sh .

# Make script executable
RUN chmod +x wait-for.sh

# Expose port used by the backend
EXPOSE 8080

# Set environment variables (overridden by docker-compose)
ENV DB_HOST=localhost \
    DB_USER=postgres \
    DB_PASSWORD=admin123 \
    DB_NAME=employees \
    DB_PORT=5432 \
    ALLOWED_ORIGINS=http://localhost:3000

# Wait for Postgres, then start server
CMD ["./wait-for.sh", "postgres", "./server"]
