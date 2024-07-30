# Stage 1: Build the application
FROM node:20-alpine AS build

WORKDIR /app

# Copy package.json and package-lock.json if available
COPY package*.json ./

RUN echo "Happy Learning"

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Stage 2: Create the final image
FROM gcr.io/distroless/nodejs:18

WORKDIR /app

# Copy the built application and node_modules from the build stage
COPY --from=build /app .

# Expose the application port
EXPOSE 3000

# Command to run the application
CMD ["npm", "start"]
