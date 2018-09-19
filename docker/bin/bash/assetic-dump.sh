#!/usr/bin/env bash

DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
. ${DIR}/../../../.env
. ${DIR}/../../.env
. ${DIR}/.env.sh

# Regenerate autoloads
#echo "eZPublish legacy regenerate autoloads \c"
#${DOCKER_APP_EXEC} php bin/php/ezpgenerateautoloads.php
#echo "${GREEN}DONE${NC}"

SYMFONY_ENV_X="${APP_ENV}"

while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -e|--env)
    SYMFONY_ENV_X="$2"
    shift # past argument
    shift # past argument
    break;;
    -e=*|--env=*)
    SYMFONY_ENV_X="${key#*=}"
    shift # past argument=value
    break;;
    *)    # unknown option
    shift # past argument
    break;;
esac
done

# Clear cache
echo -e "${GREEN}Assetic dump: ${NC}"
${DOCKER_APP_EXEC} php app/console assetic:dump --env=${SYMFONY_ENV_X} web
echo -e "${GREEN}DONE${NC}"
