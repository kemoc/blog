#!/usr/bin/env bash

# THIS SCRIPT MUST BE RUN FROM ./docker DIRECTORY!

DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
. ${DIR}/../../../.env
. ${DIR}/../../.env
. ${DIR}/.env.sh

if [ ! -d "$HOST_MARIADB_STORAGE_PATH" ] ; then
    IFS='/' read -r -a array <<< "${HOST_MARIADB_STORAGE_PATH}"

    PATH_X=""

    for index in "${!array[@]}"
    do
        #echo "$index ${array[index]}"

        if [ $index -gt "0" ]; then
            PATH_X="${PATH_X}/${array[$index]}"

            if [ ! -f "$PATH_X" ]; then
                sudo mkdir "${PATH_X}"
            fi
        fi
    done
fi

# start docker network as deamon
${DOCKER_REBUILD} $@

# ln -s ${APP_PATH}/vendor/ ./solr/data/
