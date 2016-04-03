FROM debian:wheezy
MAINTAINER Akeem McLennon <akeem@mclennon.com>

USER root
RUN echo "deb http://gce_debian_mirror.storage.googleapis.com wheezy contrib non-free" >> /etc/apt/sources.list \
  && echo "deb http://gce_debian_mirror.storage.googleapis.com wheezy-updates contrib non-free" >> /etc/apt/sources.list \
  && echo "deb http://security.debian.org/ wheezy/updates contrib non-free" >> /etc/apt/sources.list
RUN apt-get -y update
RUN apt-get -y dist-upgrade
RUN echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula \
    select true | debconf-set-selections
RUN apt-get install --no-install-recommends -y -q  \
    tar wget unzip xvfb xauth \
    ttf-kochi-gothic ttf-kochi-mincho ttf-mscorefonts-installer \
    ttf-indic-fonts ttf-dejavu-core fonts-thai-tlwg
RUN apt-get -y install git-core
WORKDIR /tmp
RUN git clone -b 2.1 --recursive https://github.com/ariya/phantomjs
RUN mv phantomjs /src
RUN wget https://github.com/detro/ghostdriver/archive/master.tar.gz
RUN tar -xzf master.tar.gz
RUN ghostdriver-master/tools/export_ghostdriver.sh /src
WORKDIR /src
RUN sh deploy/docker-build.sh
RUN cp /root/build/src/bin/phantomjs /usr/bin/ 
RUN apt-get autoremove -y
RUN apt-get clean all
ADD join-hub.sh /usr/local/bin/

ENTRYPOINT [ "sh", "-c", "/usr/local/phantomjs/join-hub.sh" ]
