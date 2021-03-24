FROM debian:buster

MAINTAINER m.krzaczkowski@yetiforce.com

COPY docker_entrypoint.sh /docker_entrypoint.sh

RUN chmod 777 /docker_entrypoint.sh

ENTRYPOINT [ "/docker_entrypoint.sh" ]
