FROM ubuntu:trusty
MAINTAINER Akeem McLennon <akeem@mclennon.com>

USER root

RUN mkdir /usr/local/phantomjs

WORKDIR /usr/local/phantomjs

RUN apt-get -y update \
      && apt-get -y dist-upgrade \
      && apt-get -y build-dep phantomjs \
      && apt-get install -y python flex bison gperf ruby perl \
                            libsqlite3-dev libfontconfig1-dev \
                            libicu-dev libfreetype6 libssl-dev \
                            libpng-dev libjpeg-dev \
                            git-core libicu52 \
                            curl \
      && curl -L https://github.com/AkeemMcLennon/phantomjs/archive/master.tar.gz | tar --strip-components=1 -xzf - \
      && ./build.sh --confirm \
      && ln -s /usr/local/phantomjs/bin/phantomjs /usr/bin/phantomjs \
      && apt-get autoremove --purge -y \
           python flex bison gperf ruby perl \
           libsqlite3-dev libsqlite3-dev libfontconfig1-dev \
           libicu-dev libssl-dev libpng-dev libjpeg-dev \
           git-core curl \
      && apt-get clean all \
      && rm -rf /usr/local/phantomjs/src /usr/local/phantomjs/test || true

COPY join-hub.sh /usr/local/phantomjs/

ENTRYPOINT [ "sh", "-c", "/usr/local/phantomjs/join-hub.sh" ]
