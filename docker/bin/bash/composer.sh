#!/usr/bin/env bash

DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
. ${DIR}/../../../.env
. ${DIR}/../../.env
. ${DIR}/.env.sh

COMPOSER_ARG="install"

#while [[ $# -gt 0 ]]
#do
#key="$1"
#
#case $key in
#    install|update)
#    COMPOSER_ARG="$1"
#    shift # past argument
#    shift # past argument
#    break;;
#    -e=*|--env=*)
#    SYMFONY_ENV_X="${key#*=}"
#    shift # past argument=value
#    break;;
#    *)    # unknown option
#    shift # past argument
#    break;;
#esac
#done

# Composer install
#echo -e "${GREEN}Start: \c"
echo -e "${GREEN}Start:${NC}"
${DOCKER_APP_EXEC} composer clear-cache
echo -e "${GREEN}composer $@${NC}"
${DOCKER_APP_EXEC} composer $@
echo -e "${GREEN}end composer command${NC}"

FOO=$1
PARAMS="$(echo -e "${FOO}" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')"

#if [ $PARAMS != "info" ]
#then
#    ${DOCKER_APP_EXEC} composer info
#fi

echo -e "${GREEN}DONE${NC}"
