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

RUN curl https://install.meteor.com | /bin/sh;

## download and install the meteor build tool
RUN meteor create --release 1.4.1.1 test \
&& rm -rf test
