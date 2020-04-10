FROM mhart/alpine-node:10 AS builder

RUN apk add python make g++

WORKDIR /app
COPY package* ./

ENV NPM_CONFIG_LOGLEVEL info
RUN npm install --production


FROM mhart/alpine-node:slim-10
LABEL maintainer="Ehsan Mokhtari"
LABEL version="6.0.2"
LABEL description="Docker file for SCC Broker Server"

RUN addgroup -g 1000 node \
    && adduser -u 1000 -G node -s /bin/sh -D node

USER node
WORKDIR /home/node
COPY --chown=node:node --from=builder /app .
COPY --chown=node:node . .

EXPOSE 8888

CMD ["node", "server.js"]