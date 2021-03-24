FROM debian:buster

MAINTAINER m.krzaczkowski@yetiforce.com

ARG DEBIAN_FRONTEND=noninteractive
ARG DB_ROOT_PASS=1r2VdePVnNxluabdGuqh

ENV PHP_VER 7.4
ENV DB_USER_NAME yetiforce
ENV DB_USER_PASS Q4WK2yRUpliyjMRivDJE
ENV DB_PORT 3306
#INSTALL_MODE = PROD , DEV , TEST
ENV INSTALL_MODE TEST

RUN ls -all /github/workspace

RUN	chmod +x /docker_entrypoint.sh

EXPOSE 80
EXPOSE 3306

ENTRYPOINT [ "/docker_entrypoint.sh" ]
