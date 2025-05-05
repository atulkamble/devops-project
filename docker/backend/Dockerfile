# Build stage
FROM golang:1.19 as build

WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN go build -o server main.go

# Final stage
FROM golang:1.19

WORKDIR /app

COPY --from=build /app/server .
COPY wait-for.sh .

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
