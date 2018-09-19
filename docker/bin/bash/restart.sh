#!/usr/bin/env bash
# THIS SCRIPT MUST BE RUN FROM ./docker DIRECTORY!

DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
. ${DIR}/../../../.env
. ${DIR}/../../.env
. ${DIR}/.env.sh

. ${DIR}/stop.sh
. ${DIR}/start.sh
