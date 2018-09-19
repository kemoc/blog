#!/usr/bin/env bash

if [ -z ${DIR+x} ]; then
# Not defined 'DIR'
    #OLD_PWD="${PWD}"
    RED='\033[0;31m'
    GREEN='\033[0;32m'
    BLUE='\033[0;34m'
    NC='\033[0m'

    DIR="$(dirname -- "$0")"
    . ${DIR}/../../../.env
    . ${DIR}/../../.env
    . ${DIR}/.env.sh

    #cd $OLD_PWD
else
    echo ""
fi

# eZPublish permissions

OLD_DIR_FPS="$DIR"
cd "$DIR/../../$APP_PATH"

echo "Files perm set PWD: $PWD"

echo -e "${GREEN}Set eZ permissions (ACL) ${NC}"
#${DOCKER_APP_EXEC_ROOT} setfacl -R -m u:${DOCKER_WWW_USER}:rx -m u:'root':rwx .
sudo setfacl -R -m u:${DOCKER_WWW_USER}:rx -m u:'root':rwx .
#${DOCKER_APP_EXEC_ROOT} setfacl -R -m u:${DOCKER_WWW_USER}:rwx var
sudo setfacl -R -m u:${DOCKER_WWW_USER}:rwx var
# permission for HOST general user
#${DOCKER_APP_EXEC_ROOT} setfacl -R -m u:${HOST_ME_UID}:rwx .
sudo setfacl -R -m u:${DOCKER_APP_ADMIN_UID}:rwx .
#${DOCKER_APP_EXEC_ROOT} setfacl -R -m u:1002:rwx ./

#${DOCKER_APP_EXEC_ROOT} setfacl -dR -m u:${DOCKER_WWW_USER}:rx -m u:'root':rwx .
sudo setfacl -dR -m u:${DOCKER_WWW_USER}:rx -m u:'root':rwx .
#${DOCKER_APP_EXEC_ROOT} setfacl -dR -m u:${DOCKER_WWW_USER}:rwx var
sudo setfacl -dR -m u:${DOCKER_WWW_USER}:rwx var
# permission for HOST general user
#${DOCKER_APP_EXEC_ROOT} setfacl -dR -m u:${HOST_ME_UID}:rwx .
sudo setfacl -dR -m u:${DOCKER_APP_ADMIN_UID}:rwx .

sudo setfacl -dR -m u:${HOST_ME_UID}:rwx .
sudo setfacl -R -m u:${HOST_ME_UID}:rwx .

OLD_PWD_FPS="$PWD"
cd docker/volumes/var/run/php-fpm && umask 0000 && cd "$OLD_PWD_FPS"
#${DOCKER_APP_EXEC_ROOT} setfacl -R -m u:${DOCKER_WWW_USER}:rwx -m u:'root':rwx docker/volumes/var/run
sudo setfacl -R -m u:${DOCKER_WWW_USER}:rwx -m u:'root':rwx docker/volumes/var/run
##sudo setfacl -R -m u:4000:rwx -m u:'root':rwx docker/app/var/run
#${DOCKER_APP_EXEC_ROOT} setfacl -dR -m u:${DOCKER_WWW_USER}:rwx -m u:'root':rwx docker/volumes/var/run
sudo setfacl -dR -m u:${DOCKER_WWW_USER}:rwx -m u:'root':rwx docker/volumes/var/run

echo -e "${GREEN}DONE${NC}"

cd "$OLD_DIR_FPS"

