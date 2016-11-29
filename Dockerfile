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
  unzip \
&& yum clean all

RUN node --version;

ENV CONSUL_FILE_NAME=consul-template_0.13.0_linux_amd64.zip
RUN wget https://releases.hashicorp.com/consul-template/0.13.0/$CONSUL_FILE_NAME \
&& unzip $CONSUL_FILE_NAME -d /usr/bin \
&& rm -rf $CONSUL_FILE_NAME
