#!/bin/bash

CONTAINER_NAME="iroha-update-binaries"

docker run --name=$CONTAINER_NAME \
           --rm="true" \
           --volumes-from "iroha-data" \
           soramitsu/iroha-dev /usr/local/iroha/scripts/update-binaries.sh
