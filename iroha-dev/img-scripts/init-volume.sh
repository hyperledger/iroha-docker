#!/bin/bash

if [[ ! "$(ls -A '/mnt/iroha')" ]]; then
    
    echo "initializing volume..."
    rsync -a /opt/iroha/* /mnt/iroha/
else
    echo "iroha is already initialized!"
fi

exit 0
