FROM ubuntu:14.04
MAINTAINER :-Datacarl <carl@lookback.io>

ENV NODE_USER node
ENV NODE_VERSION v0.10.40
ENV NODE_TAR node-$NODE_VERSION-linux-x64.tar.gz

RUN apt-get update
RUN apt-get -y install software-properties-common;
RUN apt-get -y install python-software-properties;
RUN apt-get -qq update;
RUN apt-get -y upgrade;
RUN apt-get -y install fontconfig;
RUN apt-get -y install phantomjs;
RUN apt-get -y install curl;
RUN apt-get -y install git;
RUN apt-get -y install wget;

RUN curl https://install.meteor.com | /bin/sh;

RUN adduser --shell /bin/bash --home /home/$NODE_USER --disabled-password $NODE_USER;
RUN mkdir binaries
RUN cd binaries && wget http://nodejs.org/dist/$NODE_VERSION/$NODE_TAR
RUN tar xf binaries/$NODE_TAR  --directory binaries/
RUN ls -la binaries/
RUN ln -s /binaries/node-$NODE_VERSION-linux-x64/bin/node /usr/bin/node
RUN ln -s /binaries/node-$NODE_VERSION-linux-x64/bin/npm /usr/bin/npm
RUN ls -la /usr/bin | grep 'node'
RUN node --version;

## download and install the meteor build tool
RUN meteor create --release 1.2.0.2 test
RUN cd test && meteor --get-ready
RUN rm -rf test
