FROM mhart/alpine-node:7.10
MAINTAINER Ihor Savchenko <ihor@ambisafe.co>

ARG BCOIN_VERSION

# Cache buster
ADD http://www.random.org/strings/?num=10&len=8&digits=on&upperalpha=on&loweralpha=on&unique=on&format=plain&rnd=new uuid

ENV BCOIN_BRANCH=$BCOIN_VERSION \
    BCOIN_REPO=https://github.com/bcoin-org/bcoin.git

RUN apk --no-cache add bash build-base git make python unrar \
    && mkdir -p /code/node_modules/bcoin /data \
    && git clone --branch $BCOIN_BRANCH $BCOIN_REPO /code/node_modules/bcoin \
    && cd /code/node_modules/bcoin \
    && npm install --production \
    && npm uninstall node-gyp \
    && apk del build-base make python unrar

ADD bcoin.example.conf /data/bcoin.conf

CMD ["node", "/code/node_modules/bcoin/bin/node"]
