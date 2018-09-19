#!/usr/bin/env bash

# THIS SCRIPT MUST BE RUN FROM ./docker DIRECTORY!
OLD_PWD="${PWD}"
echo "OLD_PWD: ${OLD_PWD}"

echo ""

DIR="$(dirname -- "$0")"
. ${DIR}/../../../.env
. ${DIR}/../../.env
. ${DIR}/.env.sh

NEW_PWD="${DIR}/../../.."

echo "NEW PWD: ${NEW_PWD}"

#echo "new PWD: ${NEW_PWD}"
cd "$NEW_PWD"

git config --local core.fileMode false
git config --local core.autocrlf input

git pull

cd "$OLD_PWD"

bash ${DIR}/files-permission-set.sh

${DOCKER_APP_EXEC} composer clear-cache
${DOCKER_APP_EXEC} composer install
${DOCKER_APP_EXEC} composer dump-autoload --optimize
${DOCKER_APP_EXEC} composer info

bash ${DIR}/cache-clear.sh -e dev
bash ${DIR}/cache-clear.sh -e prod

${DOCKER_APP_EXEC} php bin/console assets:install --relative --symlink

#bash ${DIR}/files-permission-set.sh




