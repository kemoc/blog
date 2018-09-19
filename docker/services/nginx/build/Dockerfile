FROM nginx:1.13
MAINTAINER Radek Z <radek.dev@gmail.com>

# https://hub.docker.com/_/php/
# https://blog.serverdensity.com/troubleshoot-nginx/
# https://coderwall.com/p/hmsr5a/have-php-fpm-listen-on-unix-socket
# https://serversforhackers.com/c/php-fpm-configuration-the-listen-directive

# Set usermod
RUN usermod -u 4000 nginx
RUN groupmod -g 4000 nginx

# Update sources
RUN apt update -y

RUN apt install -y build-essential

RUN apt install -y apt-utils

RUN apt-get install -y acl lsof
RUN apt-get install -y net-tools

RUN apt install -y g++

# Install GIT
RUN apt install -y git

# Install unzip
RUN apt-get install -y zip unzip

# Install Midnight Commander, Vim, Nano
RUN apt-get install -y vim nano

RUN apt-get install -y mysql-client

# Install libssl
RUN apt-get install -y libssl-dev

# Install GRUNT
#RUN npm install -g grunt-cli

RUN apt install -y wget

ENV OLD_CPPFLAGS="$CPPFLAGS"
ENV CPPFLAGS="$OLD_CPPFLAGS -std=c++11"

ENV OLD_CXXFLAGS="$CXXFLAGS"
ENV CXXFLAGS="$OLD_CXXFLAGS -std=c++11"

# @todo: installation procedure of newer ICU (v59)
# https://github.com/webdevops/Dockerfile/issues/191
# https://github.com/docker-library/php/issues/455
RUN apt-get install -y libicu-dev
RUN mkdir /tmp/icu-source
RUN cd /tmp/icu-source
WORKDIR /tmp/icu-source
RUN wget 'http://download.icu-project.org/files/icu4c/60.2/icu4c-60_2-src.tgz' && \
    tar -zxvf icu4c-60_2-src.tgz
RUN cd /tmp/icu-source/icu/source
WORKDIR /tmp/icu-source/icu/source
RUN chmod +x runConfigureICU configure install-sh
RUN ./configure --prefix=/usr/local && \
    make
RUN make install
RUN cd ~
WORKDIR /root

ENV CPPFLAGS="$OLD_CPPFLAGS"
ENV CXXFLAGS="$OLD_CXXFLAGS"

RUN rm -rf /tmp/icu*


RUN apt install -y curl
RUN apt update
RUN apt install -y libcurl3
RUN apt install -y libcurl3-dev
RUN apt install -y zlib1g-dev
#RUN apt install -y libcurl4-openssl-dev

# Apply Apache2 configs
#RUN a2ensite 000-default.conf


# Install ImageMagick
RUN apt-get install -y imagemagick
RUN apt-get install -y \
    libmagickwand-dev \
    --no-install-recommends

# Setup timezone
ENV TZ="Europe/Paris"
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install NodeJS
#RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
#RUN apt-get install -y nodejs

# Set workdir
WORKDIR /var/www/project

# Cleanup the image
RUN rm -rf /var/lib/apt/lists/* /tmp/*
