#!/usr/bin/env bash

#DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
#. ${DIR}/../../.env


#DIR="$(dirname -- "$0")"
#. ${DIR}/../../.env

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

# DOCKER_ENV="dev|preprod"
DOCKER_ENV="dev"

# ="dev|prod"
#SYMFONY_ENV="dev"

COMPOSE_PROJECT_NAME="radek-blog"
DOCKER_WWW_USER="4000"
HOST_ME_UID="${UID}"
DOCKER_APP_ADMIN_UID="1000"

DOCKER_BUILD="docker-compose -p ${COMPOSE_PROJECT_NAME} build --pull"
#DOCKER_BUILD="docker-compose -p ${COMPOSE_PROJECT_NAME} build --no-cache --pull"
DOCKER_REBUILD="docker-compose -p ${COMPOSE_PROJECT_NAME} build --no-cache --pull"
#docker-compose -p geo-distance build --no-cache --pull app

DOCKER_DAEMON_START="docker-compose -p ${COMPOSE_PROJECT_NAME} up -d"
DOCKER_DAEMON_STOP="docker-compose -p ${COMPOSE_PROJECT_NAME} stop"

DOCKER_APP_PATH="/var/www/project"
DOCKER_APP_EXEC_ROOT="docker-compose -p ${COMPOSE_PROJECT_NAME} exec app"
DOCKER_APP_EXEC_ROOT_BASH="docker-compose -p ${COMPOSE_PROJECT_NAME} exec app bash"
#DOCKER_APP_EXEC_ROOT="docker-compose -p geo-distance exec app bash"

DOCKER_APP_EXEC="docker-compose -p ${COMPOSE_PROJECT_NAME} exec --user=${DOCKER_APP_ADMIN_UID} app"
DOCKER_APP_EXEC_BASH="docker-compose -p ${COMPOSE_PROJECT_NAME} exec --user=${DOCKER_APP_ADMIN_UID} app bash"

DOCKER_NGINX_EXEC_ROOT="docker-compose -p ${COMPOSE_PROJECT_NAME} exec nginx"
DOCKER_NGINX_EXEC_ROOT_BASH="docker-compose -p ${COMPOSE_PROJECT_NAME} exec nginx bash"
#DOCKER_NGINX_EXEC_NGINX="docker-compose -p geo-distance exec nginx bash"

DOCKER_NGINX_EXEC_NGINX_BASH="docker-compose -p ${COMPOSE_PROJECT_NAME} exec --user nginx nginx bash"
#DOCKER_NGINX_EXEC_NGINX="docker-compose -p geo-distance exec --user nginx nginx bash"

DOCKER_PHPMYADMIN_EXEC_ROOT_SH="docker-compose -p ${COMPOSE_PROJECT_NAME} exec phpmyadmin sh"
#DOCKER_PHPMYADMIN_EXEC_ROOT_SH="docker-compose -p geo-distance exec phpmyadmin sh"

DOCKER_SQL_ENGINE_EXEC_ROOT_BASH="docker-compose -p ${COMPOSE_PROJECT_NAME} exec mariadb bash"
#DOCKER_SQL_ENGINE_EXEC_ROOT="docker-compose -p geo-distance exec mariadb bash"

