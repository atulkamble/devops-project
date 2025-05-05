# Use official Go image
FROM golang:1.19

# Set working directory inside container
WORKDIR /app

# Copy go.mod and go.sum files (to cache dependencies)
COPY go.mod go.sum ./

# Download dependencies
RUN go mod download

# Copy the rest of the application code
COPY . .

# Build the Go application (optional - can use go run as well)
RUN go build -o main .

# Expose backend port
EXPOSE 8080

# Run using environment variables
CMD ["./main"]
