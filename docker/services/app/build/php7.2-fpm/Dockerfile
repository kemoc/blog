FROM php:7.2-fpm
MAINTAINER Radek Z <radek.dev@gmail.com>

# Set usermod
RUN usermod -u 4000 www-data
RUN groupmod -g 4000 www-data

#COPY ./docker-entrypoint.sh /
#ENTRYPOINT ["/docker-entrypoint.sh"]

RUN useradd -m -u 1000 admin
RUN usermod -aG root admin
# https://hub.docker.com/_/php/

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
#RUN apt-get install -y mc
RUN apt-get install -y vim nano

RUN apt install -y wget

RUN apt-get install -y mysql-client

# Install libssl
RUN apt-get install -y libssl-dev

# Install GRUNT
#RUN npm install -g grunt-cli

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

#ENV CPPFLAGS="$OLD_CPPFLAGS"
ENV CXXFLAGS="$OLD_CXXFLAGS"

RUN rm -rf /tmp/icu*


# PHP_CPPFLAGS are used by the docker-php-ext-* scripts
#ENV OLD_PHP_CPPFLAGS = "$PHP_CPPFLAGS"
#ENV PHP_CPPFLAGS="$PHP_CPPFLAGS -std=c++11"
# run configure and install in the same RUN line, they extract and clean up the php source to save space
RUN docker-php-ext-configure intl --with-icu-dir=/usr/local
#RUN pecl install intl
RUN docker-php-ext-install intl
RUN docker-php-ext-enable intl

#ENV PHP_CPPFLAGS="$OLD_PHP_CPPFLAGS"

RUN apt install -y curl
RUN apt install -y libcurl3
RUN apt install -y libcurl3-dev
RUN apt install -y zlib1g-dev
RUN apt update
#RUN apt install -y libcurl4-openssl-dev
RUN docker-php-ext-install curl
RUN docker-php-ext-enable curl

#RUN mkdir /tmp/php-source
#WORKDIR /tmp/php-source
#RUN wget 'http://cz1.php.net/distributions/php-7.1.12.tar.gz'
#RUN tar -zxvf php-7.1.12.tar.gz
#WORKDIR /tmp/php-source/php-7.1.12/ext/intl
#RUN phpize && \
#    ./configure --enable-intl && \
#    make && \
#    make install
#RUN echo "extension=intl.so" > /usr/local/etc/php/conf.d/intl.ini
#WORKDIR /
#RUN cd ~

#RUN apt-get install icu-devtools
#RUN apt-get install icu-doc
#RUN apt-get install libicu-dev
#RUN apt-get install libicu52
#RUN apt-get install libicu52-dbg -y

#RUN pecl install intl
#RUN docker-php-ext-install intl
#RUN docker-php-ext-enable intl

RUN pecl install apcu
RUN docker-php-ext-enable apcu

# Install xdebug for dev
RUN pecl install xdebug
RUN docker-php-ext-enable xdebug

#RUN echo "error_reporting = E_ALL" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
#RUN echo "display_startup_errors = On" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
#RUN echo "display_errors = On" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
#RUN echo "xdebug.remote_enable=1" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
#RUN echo "xdebug.remote_connect_back=1" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
#RUN echo "xdebug.idekey=\"PHPSTORM\"" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
#RUN echo "xdebug.remote_port=9001" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

# Add custom Apache configs
#RUN rm /etc/apache2/sites-available/000-default.conf
#ADD ./vhost.conf /etc/apache2/sites-available/000-default.conf
#ADD ./project/apache2/rewrites.conf /etc/apache2/includes/project-rewrites.conf
#ADD ./project/apache2/log.conf /etc/apache2/includes/project-log.conf
#ADD ./project/apache2/rewrites.conf /etc/apache2/includes/project-rewrites.conf
#ADD ./project/apache2/cache.conf /etc/apache2/includes/project-cache.conf


RUN apt install -y zlib1g-dev

# Install PHP modules
RUN apt-get install -y zlib1g-dev
RUN docker-php-ext-install zip
RUN docker-php-ext-enable zip

RUN apt install -y libxml2-dev
RUN docker-php-ext-install xml
RUN docker-php-ext-enable xml

RUN docker-php-ext-install opcache
RUN docker-php-ext-enable opcache

# apcu-4.0.10 is for PHP 5.6
#RUN pecl install apcu-4.0.10
#RUN echo "extension=apcu.so" > /usr/local/etc/php/conf.d/apcu.ini
#RUN docker-php-ext-install apcu
#RUN docker-php-ext-enable apcu

RUN docker-php-ext-install mbstring
RUN docker-php-ext-enable mbstring

# Install ImageMagick
RUN apt-get install -y imagemagick
RUN apt-get install -y \
    libmagickwand-dev \
    --no-install-recommends
RUN pecl install imagick
RUN docker-php-ext-enable imagick

# Install XSL
RUN apt-get install -y libxslt-dev
RUN docker-php-ext-install xsl

# Install SOAP
RUN docker-php-ext-install -j$(nproc) soap
RUN docker-php-ext-enable soap

#RUN apt-get install -y libz-dev libmemcached-dev memcached
#RUN pecl install memcached
##RUN echo "extension=memcached.so" > /usr/local/etc/php/conf.d/memcached.ini
#RUN docker-php-ext-enable memcached

# Install GD
#RUN apt-get install -y libfreetype6-dev libjpeg62-turbo-dev libjpeg-dev libpng12-dev
RUN apt-get install -y libfreetype6-dev libjpeg62-turbo-dev libjpeg-dev libpng-dev
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/
RUN docker-php-ext-install -j$(nproc) gd

# Install PHP "pdo" extension with "mysql", "pgsql", "sqlite" drivers – http://php.net/manual/pl/book.pdo.php
RUN apt-get install -y libpq-dev libsqlite3-dev
#RUN docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql
#RUN docker-php-ext-install pgsql pdo_pgsql
RUN docker-php-ext-install mysqli pdo pdo_mysql pdo_sqlite

# Setup timezone
ENV TZ="Europe/Paris"
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN echo "date.timezone=$TZ" >> /usr/local/etc/php/conf.d/default.ini

# Add custom php.ini
#COPY ./apache-php7.1/project/php/php.ini /usr/local/etc/php/conf.d/z_project_php.ini


# Install Java for Solr
#RUN apt-get install -y openjdk-8-jdk

# Install NodeJS
RUN apt-get install -my gnupg
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get install -y nodejs

# Install Composer
RUN curl -sS https://getcomposer.org/download/1.6.5/composer.phar > /usr/local/bin/composer
RUN chmod a+x /usr/local/bin/composer
RUN composer --version

RUN apt install -y ruby-sass
RUN npm install -g grunt-cli

# Set workdir
WORKDIR /var/www/project
RUN cd /var/www/project

#RUN composer install
#RUN composer dump-autoload --optimize

# Cleanup the image
RUN rm -rf /var/lib/apt/lists/* /tmp/*
