# Stage 1: Build the application
FROM node:20-alpine AS build

WORKDIR /app

# Copy package.json and package-lock.json if available
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the React application
RUN npm run build

# Stage 2: Serve the application
FROM nginx:stable-alpine

# Copy built assets from the build stage
COPY --from=build /app/build /usr/share/nginx/html

# Copy custom nginx config if necessary
# COPY nginx.conf /etc/nginx/nginx.conf

# Expose the port that the app runs on
EXPOSE 3000

# Start nginx server
CMD ["nginx", "-g", "daemon off;"]
