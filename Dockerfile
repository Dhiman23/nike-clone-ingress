FROM node:latest as Base

WORKDIR /app

COPY package.json .

RUN npm install

COPY . .

FROM gcr.io/distroless/base

COPY --from=base /main/app .
COPY --from=base /app/src ./src
EXPOSE 3000

CMD [ "npm", "start" ]
