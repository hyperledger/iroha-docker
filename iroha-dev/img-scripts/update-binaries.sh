#!/bin/bash

# update binaries
if [[ "$(ls -A '/mnt/iroha/build')" ]]; then
    echo "updating binaries..."

    rsync -av -I /mnt/iroha/build/bin $IROHA_HOME
    rsync -av -I /mnt/iroha/build/lib $IROHA_HOME
    rsync -av -I /mnt/iroha/build/my_test_bin $IROHA_HOME 
    rsync -av -I /mnt/iroha/build/test_bin $IROHA_HOME 
    rsync -av -I /mnt/iroha/core/vendor/ed25519/lib $IROHA_HOME
fi
