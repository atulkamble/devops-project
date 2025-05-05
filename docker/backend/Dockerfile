# Use official Go image
FROM golang:1.19 as build

# Set the working directory inside the container
WORKDIR /app

# Copy go mod files and download dependencies first (cache-friendly)
COPY go.mod go.sum ./
RUN go mod download

# Copy the rest of the backend source code
COPY . .

# Build the Go binary
RUN go build -o server main.go

# -------- Final runtime container --------
FROM golang:1.19

# Set working directory
WORKDIR /app

# Copy the built Go binary from the build stage
COPY --from=build /app/server .

# Set environment variables (they will be overridden by docker-compose)
ENV DB_HOST=localhost \
    DB_USER=postgres \
    DB_PASSWORD=admin123 \
    DB_NAME=employees \
    DB_PORT=5432 \
    ALLOWED_ORIGINS=http://localhost:3000

# Expose backend port
EXPOSE 8080

# Run the backend
CMD ["./server"]
