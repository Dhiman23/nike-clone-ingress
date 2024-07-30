# Stage 1: Build the application
FROM node:20-alpine AS build

WORKDIR /app

COPY package.json .

RUN npm install

COPY . .

# Stage 2: Create the final image
FROM gcr.io/distroless/nodejs

WORKDIR /app

COPY --from=build /app .

# Expose the application port
EXPOSE 3000

# Command to run the application
CMD ["node", "src/index.js"]