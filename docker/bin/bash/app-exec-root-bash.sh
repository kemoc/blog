#!/usr/bin/env bash

DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

. ${DIR}/../../../.env
. ${DIR}/../../.env
. ${DIR}/.env.sh

ARG_STRING=""

#while [[ $# -gt 0 ]]
#do

#ARG_STRING="${ARG_STRING} $1"

#done

${DOCKER_APP_EXEC_ROOT_BASH}
