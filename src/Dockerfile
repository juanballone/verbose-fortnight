# Stage 1: Build Stage
FROM node:current-slim AS build

# Set a non-root user for security
RUN useradd --create-home --shell /bin/bash appuser

# Set the working directory
WORKDIR /usr/src/app

# Copy package files first to leverage Docker caching
COPY package.json ./

# Install dependencies
RUN npm install --production

# Copy application files
COPY . .

# Change ownership to the non-root user
RUN chown -R appuser:appuser /usr/src/app

# Switch to non-root user
USER appuser

# Stage 2: Runtime Stage
FROM node:current-slim

# Set a non-root user for security
RUN useradd --create-home --shell /bin/bash appuser

# Install curl for Dcoker healthcheck
RUN apt-get update && apt-get install -y curl

# Set the working directory
WORKDIR /usr/src/app

# Copy only the necessary files from the build stage
COPY --from=build /usr/src/app /usr/src/app

# Expose the application port
EXPOSE 3000

# Use a non-root user for security
USER appuser

# Start the application
CMD ["node", "app.js"]
