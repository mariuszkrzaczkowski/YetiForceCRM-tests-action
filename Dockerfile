FROM debian:buster

MAINTAINER m.krzaczkowski@yetiforce.com

ARG DEBIAN_FRONTEND=noninteractive
ARG DB_ROOT_PASS=1r2VdePVnNxluabdGuqh

#ENV INPUT_PHP 7.2
ENV DB_USER_NAME yetiforce
ENV DB_USER_PASS Q4WK2yRUpliyjMRivDJE
ENV DB_PORT 3306
#INSTALL_MODE = PROD , DEV , TEST
ENV INSTALL_MODE TEST

ENV PROVIDER docker

RUN printenv

RUN apt-get update && apt-get install -y --no-install-recommends apt-utils curl openssl wget ca-certificates apt-transport-https lsb-release gnupg && apt-get -y autoclean

RUN wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
RUN echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list
RUN	curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update
RUN apt-get install -y --no-install-recommends mariadb-server mariadb-client nginx nginx-extras "php${INPUT_PHP}"-fpm "php${INPUT_PHP}"-mysql "php${INPUT_PHP}"-curl "php${INPUT_PHP}"-intl "php${INPUT_PHP}"-gd "php${INPUT_PHP}"-fpm "php${INPUT_PHP}"-bcmath "php${INPUT_PHP}"-soap "php${INPUT_PHP}"-ldap "php${INPUT_PHP}"-imap "php${INPUT_PHP}"-xml "php${INPUT_PHP}"-cli "php${INPUT_PHP}"-zip "php${INPUT_PHP}"-json "php${INPUT_PHP}"-opcache "php${INPUT_PHP}"-mbstring php-apcu php-imagick php-sodium zip unzip cron nodejs npm yarn && apt-get -y autoclean
RUN apt-get install -y --no-install-recommends mc htop openssh-server git && apt-get -y autoclean

# RUN apt-cache search php
RUN dpkg --get-selections | grep php

RUN rm /var/www/html/index.nginx-debian.html
RUN echo "PROVIDER=docker" > /etc/environment

RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer
RUN chmod +x /usr/local/bin/composer

COPY docker_entrypoint.sh /docker_entrypoint.sh

RUN chmod 777 /docker_entrypoint.sh

WORKDIR /var/www/html

EXPOSE 80

ENTRYPOINT [ "/docker_entrypoint.sh" ]
