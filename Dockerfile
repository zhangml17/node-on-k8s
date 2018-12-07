FROM node:11.3-alpine
WORKDIR app
COPY ./server.js .
EXPOSE 3000
ENTRYPOINT [ "node", "server.js"]
