#!/bin/bash

WORKING_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
source $WORKING_DIR/../params.sh

CONTAINER_NAME="iroha-data"

CONTAINER_STATUS=$(docker inspect --format="{{ .State.Running }}" $CONTAINER_NAME 2> /dev/null)
if [[ "$CONTAINER_STATUS" == "true" || "$CONTAINER_STATUS" == "false" ]]; then
    echo "data container was already created!"
else
    docker run --name="$CONTAINER_NAME" \
           -v "$IROHA_HOST_DIR:/mnt/iroha" \
           soramitsu/iroha-dev /usr/local/iroha/scripts/init-volume.sh 
fi
