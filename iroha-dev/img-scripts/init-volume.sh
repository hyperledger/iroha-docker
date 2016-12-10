#!/bin/bash

if [[ ! "$(ls -A '/mnt/iroha')" ]]; then
    
    #if [[ ! -z "$1" ]]; then
    #    IROHA_OWNER=$1
    #else
    #    echo -n -e "Enter iroha project dir owner.\n"; read IROHA_OWNER
    #fi

    echo "initializing volume..."
    rsync -a /opt/iroha/* /mnt/iroha/
    #chown -R $IROHA_OWNER /mnt/iroha/
else
    echo "iroha is already initialized!"
fi

exit 0
