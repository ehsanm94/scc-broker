FROM node:10.20.0-alpine AS builder

WORKDIR /srv

RUN apk add --update \ 
        g++ \
        make \
        python \
    && npm install uws@10.148.0


FROM node:10.20.0-alpine
LABEL maintainer="Ehsan Mokhtari"

LABEL version="6.0.2"
LABEL description="Docker file for SCC Broker Server"

USER node
WORKDIR /home/node
COPY . .

RUN npm install --production

COPY --chown=node:node --from=builder /srv/node_modules/uws node_modules/uws

EXPOSE 8888

CMD ["npm", "start"]
