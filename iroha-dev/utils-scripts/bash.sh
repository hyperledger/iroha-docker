#!/bin/bash

CONTAINER_NAME="iroha-bash"

docker run --name=$CONTAINER_NAME \
           --rm="true" \
           --volumes-from "iroha-data" \
           -it \
           soramitsu/iroha-dev 
