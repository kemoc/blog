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

echo -e "${GREEN}Docker command: ${NC}"
echo -e "${DOCKER_APP_EXEC_ROOT_2} $@"
${DOCKER_APP_EXEC} $@
echo -e "${GREEN}DONE${NC}"
