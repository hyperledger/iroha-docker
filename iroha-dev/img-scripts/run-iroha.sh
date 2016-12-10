#!/bin/bash

# update binaries
/usr/local/iroha/scripts/update-binaries.sh

# run iroha
su - iroha
export IROHA_HOME="/usr/local/iroha"
/usr/local/iroha/bin/iroha-main
