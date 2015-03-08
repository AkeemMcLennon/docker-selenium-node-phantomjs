FROM ubuntu:trusty
MAINTAINER Akeem McLennon <akeem@mclennon.com>

USER root
RUN apt-get -y update
RUN apt-get -y dist-upgrade
RUN apt-get -y build-dep phantomjs
RUN apt-get install -y python flex bison gperf ruby perl \
  libsqlite3-dev libfontconfig1-dev libicu-dev libfreetype6 libssl-dev \
  libpng-dev libjpeg-dev
RUN apt-get -y install git-core
WORKDIR /usr/local
RUN git clone https://github.com/AkeemMcLennon/phantomjs.git
WORKDIR /usr/local/phantomjs
RUN ./build.sh --confirm
RUN ln -s /usr/local/phantomjs/bin/phantomjs /usr/bin/phantomjs 
RUN apt-get autoremove -y
RUN apt-get clean all
ADD join-hub.sh /usr/local/phantomjs/
ENTRYPOINT sh /usr/local/phantomjs/join-hub.sh

