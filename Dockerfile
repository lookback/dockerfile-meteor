FROM centos:7
MAINTAINER :-Datacarl <carl@lookback.io>

RUN curl --silent --location https://rpm.nodesource.com/setup_4.x | bash -

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
  nodejs-4.5.0 \
&& yum clean all

RUN node --version;

RUN mkdir -p /opt/phantomjs
ENV PHANTOM_FILE_NAME=phantomjs-1.9.8-linux-x86_64.tar.bz2
RUN wget https://bitbucket.org/ariya/phantomjs/downloads/$PHANTOM_FILE_NAME \
&& tar -xjf $PHANTOM_FILE_NAME --strip-components 1 -C /opt/phantomjs/ \
&& ln -s /opt/phantomjs/bin/phantomjs /usr/bin/phantomjs \
&& rm -rf $PHANTOM_FILE_NAME

RUN curl https://install.meteor.com | /bin/sh;

## download and install the meteor build tool
RUN meteor create --release 1.4.1.1 test \
&& cd test && meteor --get-ready \
&& cd .. && rm -rf test
