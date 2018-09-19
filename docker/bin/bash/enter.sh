#!/usr/bin/env bash

DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

. ${DIR}/../../../.env
. ${DIR}/../../.env
. ${DIR}/.env.sh

ARG_STRING=""

SERVICE=app
LOCAL_SHELL=sh
#while [[ $# -gt 0 ]]
#do
#
#ARG_STRING="${ARG_STRING} $1"
#
#done

docker-compose -p ${COMPOSE_PROJECT_NAME} exec $@
