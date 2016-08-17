FROM centos:7
MAINTAINER :-Datacarl <carl@lookback.io>

ENV NODE_VERSION v0.10.43
ENV NODE_TAR node-$NODE_VERSION-linux-x64.tar.gz

RUN yum -y update && yum -y upgrade && yum -y install \
  curl \
  git \
  wget \
  tar \
  fontconfig \
  freetype \
  freetype-devel \
  fontconfig-devel \
  libstdc++ \
  bzip2 \
  # make and gcc to install fibers with npm http://stackoverflow.com/questions/14772508/npm-failed-to-install-time-with-make-not-found-error
  make \
  gcc* \
&& yum clean all

RUN mkdir -p /opt/phantomjs
ENV PHANTOM_FILE_NAME=phantomjs-1.9.8-linux-x86_64.tar.bz2
RUN wget https://bitbucket.org/ariya/phantomjs/downloads/$PHANTOM_FILE_NAME \
&& tar -xjf $PHANTOM_FILE_NAME --strip-components 1 -C /opt/phantomjs/ \
&& ln -s /opt/phantomjs/bin/phantomjs /usr/bin/phantomjs \
&& rm -rf $PHANTOM_FILE_NAME

RUN curl https://install.meteor.com | /bin/sh;

RUN mkdir binaries
RUN cd binaries && wget http://nodejs.org/dist/$NODE_VERSION/$NODE_TAR
RUN tar xf binaries/$NODE_TAR  --directory binaries/
RUN ls -la binaries/
RUN ln -s /binaries/node-$NODE_VERSION-linux-x64/bin/node /usr/bin/node
RUN ln -s /binaries/node-$NODE_VERSION-linux-x64/bin/npm /usr/bin/npm
RUN ls -la /usr/bin | grep 'node'
RUN node --version;

## download and install the meteor build tool
RUN meteor create --release 1.3.4.4 test \
&& cd test && meteor --get-ready \
&& cd .. && rm -rf test
