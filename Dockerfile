# Stage 1: Build the application
FROM node:latest AS build

WORKDIR /app

COPY package.json .

RUN npm install

COPY . .

# Stage 2: Create the final image
FROM gcr.io/distroless/nodejs

WORKDIR /app

COPY --from=build /app .

EXPOSE 3000

CMD ["npm", "start"]