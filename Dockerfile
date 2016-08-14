FROM centos:7
MAINTAINER :-Datacarl <carl@lookback.io>

ENV NODE_VERSION v0.10.43
ENV NODE_TAR node-$NODE_VERSION-linux-x64.tar.gz

RUN yum -y update
RUN yum -y upgrade;
RUN yum -y install curl;
RUN yum -y install git;
RUN yum -y install wget;
RUN yum -y install tar;
RUN yum -y install fontconfig freetype freetype-devel fontconfig-devel libstdc++
RUN yum -y install bzip2;

# to install fibers with npm http://stackoverflow.com/questions/14772508/npm-failed-to-install-time-with-make-not-found-error
RUN yum install -y make gcc*

RUN wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-1.9.8-linux-x86_64.tar.bz2

RUN mkdir -p /opt/phantomjs
RUN tar -xjf phantomjs-1.9.8-linux-x86_64.tar.bz2 --strip-components 1 -C /opt/phantomjs/
RUN ln -s /opt/phantomjs/bin/phantomjs /usr/bin/phantomjs

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
RUN meteor create --release 1.3.4.4 test
RUN cd test && meteor --get-ready
RUN rm -rf test
