FROM node:latest as Base

WORKDIR /app

COPY package.json .

RUN npm install

COPY . .

FROM gcr.io/distroless/base

COPY --from=base /app/main .
COPY --from=base /app/src ./src
EXPOSE 3000

CMD [ "npm", "start" ]
