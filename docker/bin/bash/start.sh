#!/usr/bin/env bash

# THIS SCRIPT MUST BE RUN FROM ./docker DIRECTORY!

DIR="$(dirname -- "$0")"
. ${DIR}/../../../.env
. ${DIR}/../../.env
. ${DIR}/.env.sh

# start docker network as deamon
${DOCKER_DAEMON_START}

cd volumes/var/run/php-fpm && umask 0000 && cd ./../../../..
${DOCKER_NGINX_EXEC_ROOT} setfacl -R -m u:${DOCKER_WWW_USER}:rwx -m u:'root':rwx docker/volumes/var/run
#sudo setfacl -dR -m u:'4000':rwx -m o::rwx -m u:'root':rwx volumes/var/run
${DOCKER_NGINX_EXEC_ROOT} setfacl -dR -m u:${DOCKER_WWW_USER}:rwx -m u:'root':rwx docker/volumes/var/run
#sudo setfacl -dR -m u:'4000':rwx -m o::rwx -m u:'root':rwx volumes/var/run

