FROM node:10.16.0-alpine

RUN mkdir -p /home/node/app && \
    chown node:node /home/node/app

WORKDIR /home/node/app

USER node

COPY app/package.json app/yarn.lock ./

RUN echo $PWD && ls -la && yarn install

EXPOSE 3000

CMD [ "yarn", "start" ]
