# Start from the golang base image
FROM golang:1.22.0-alpine as builder

# Set the Current Working Directory inside the container
WORKDIR /app

# Copy go source
COPY main.go main.go

# Build the Go app
RUN go build -o webapp main.go

# Start a new stage from scratch
FROM alpine:3.19.1

# Create a non-root user and group
# Note: You may need to install 'shadow' package to use 'useradd' or 'groupadd'
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Set the Current Working Directory inside the container
WORKDIR /home/appuser

# Copy the Pre-built binary file from the previous stage
COPY --from=builder /app/webapp .

# Change ownership of the workdir
RUN chown -R appuser:appgroup /home/appuser

# Use the non-root user to run the application
USER appuser

# Expose port 3000
EXPOSE 3000

# Command to run the executable
CMD ["./webapp"]

# Add a health check
HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 \
CMD wget --quiet --tries=1 --spider http://localhost:3000/ || exit 1
