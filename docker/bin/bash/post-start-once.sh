#!/usr/bin/env bash

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

if [ -z ${DIR+x} ]; then
# Not defined 'DIR'
    #OLD_PWD="${PWD}"

    DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
    . ${DIR}/../../../.env
    . ${DIR}/../../.env
    . ${DIR}/.env.sh

    #cd $OLD_PWD
else
    echo ""
fi

if [ ! -f "web/var" ]; then
    mkdir web/var
fi

# Permissions
#echo "Set dir www permission (user: ${DOCKER_WWW_USER}:${DOCKER_WWW_USER}) ${DOCKER_APP_PATH}/var/\c"
#${DOCKER_APP_EXEC_ROOT} chmod -R ugo+rx /var/www
#${DOCKER_API_EXEC_ROOT} chown -R ${DOCKER_WWW_USER}:${DOCKER_WWW_USER} ${DOCKER_APP_PATH}/var/
#echo "Set dir ${GREEN}DONE${NC}"

# Composer install
echo -e "${GREEN}Install Composer vendors: ${NC}"
${DOCKER_APP_EXEC} composer clear-cache
${DOCKER_APP_EXEC} composer install
${DOCKER_APP_EXEC} composer info
echo -e "${GREEN}DONE${NC}"

# Create site.ini.append.php
#echo "Create site.ini file \c"
#${DOCKER_APP_EXEC} cp settings/override/site.ini.append.php.dist.${DOCKER_ENV}.php settings/override/site.ini.append.php
#echo "${GREEN}DONE${NC}"

# Regenerate autoloads
#echo "eZPublish legacy regenerate autoloads \c"
#${DOCKER_APP_EXEC} php bin/php/ezpgenerateautoloads.php
#echo "${GREEN}DONE${NC}"

# Install node modules
#echo "Install node modules \c"
#${DOCKER_APP_EXEC} npm install
#echo "${GREEN}DONE${NC}"

# Dump assets
#echo "Assetic dump \c"
#${DOCKER_APP_EXEC} php ezpublish/console assetic:dump
#echo "${GREEN}DONE${NC}"

# eZPublish permissions
. ${DIR}/files-permission-set.sh

#echo "Set eZ permissions (ACL) \c"
#${DOCKER_APP_EXEC} setfacl -R -m u:${DOCKER_WWW_USER}:rx -m u:'root':rwx ./
#${DOCKER_APP_EXEC} setfacl -R -m u:${DOCKER_WWW_USER}:rwx -m u:'root':rwx var/cache var/logs var/sessions web
#
#${DOCKER_APP_EXEC} setfacl -dR -m u:${DOCKER_WWW_USER}:rx -m u:'root':rwx ./
#${DOCKER_APP_EXEC} setfacl -dR -m u:${DOCKER_WWW_USER}:rwx -m u:'root':rwx var/cache var/logs var/sessions web
#echo "${GREEN}DONE${NC}"

# Clear cache
echo -e "${GREEN}Assets, assetic, clear cache ${NC}"
${DOCKER_APP_EXEC} php app/console assetic:dump --env=prod web
${DOCKER_APP_EXEC} php app/console assetic:dump --env=dev web
${DOCKER_APP_EXEC} php app/console assets:install --relative --symlink web
${DOCKER_APP_EXEC} php app/console cache:clear --env=${SYMFONY_ENV}
echo -e "${GREEN}DONE${NC}"
echo ""
echo -e "${GREEN}Finished! ${NC}"
echo ""
