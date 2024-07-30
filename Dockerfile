# Stage 1: Build the application
FROM node:20-alpine AS build

WORKDIR /app

# Copy package.json and package-lock.json if available
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Debug: List contents of /app/src directory
RUN ls -al /app/src

# Stage 2: Create the final image
FROM gcr.io/distroless/nodejs

WORKDIR /app

# Copy the built application and node_modules from the build stage
COPY --from=build /app .

# Debug: List contents of /app/src directory
RUN ls -al /app/src

# Expose the application port
EXPOSE 3000

# Command to run the application
CMD ["node", "src/index.js"]