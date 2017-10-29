FROM archlinux/base:latest
MAINTAINER Ihor Savchenko <ihor@ambisafe.co>

ARG BCOIN_VERSION

USER root

RUN pacman -Syy --needed --noconfirm sudo gcc python unrar make shadow vim vim-runtime git nodejs npm
RUN useradd -mU -s /bin/bash docker && echo 'docker:docker' | chpasswd
RUN echo "docker ALL=(ALL:ALL) NOPASSWD:ALL" | (EDITOR="tee -a" visudo)
RUN mkdir /data && chown docker /data

USER docker

# Cache buster
ADD http://www.random.org/strings/?num=10&len=8&digits=on&upperalpha=on&loweralpha=on&unique=on&format=plain&rnd=new uuid

ENV BCOIN_BRANCH $BCOIN_VERSION
ENV BCOIN_REPO https://github.com/bcoin-org/bcoin.git

RUN mkdir -p ~/.bcoin /data \
    && git clone --branch $BCOIN_BRANCH $BCOIN_REPO ~/.bcoin \
    && cd ~/.bcoin \
    && npm install --production \
    && npm uninstall node-gyp

ADD bcoin.example.conf ~/.bcoin/bcoin.conf

VOLUME /data

EXPOSE 8332 8333

CMD ["node", "/home/docker/.bcoin/bin/node"]
