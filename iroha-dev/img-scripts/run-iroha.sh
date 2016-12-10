#!/bin/bash

su - iroha -c "env IROHA_HOME='/usr/local/iroha' /usr/local/iroha/bin/iroha-main"
#su - iroha
#export IROHA_HOME="/usr/local/iroha"
#/usr/local/iroha/bin/iroha-main
#CMD ["/bin/su","-","iroha","-c","env IROHA_HOME=/usr/local/iroha /usr/local/iroha/bin/iroha-main"]
#/bin/su - iroha -c "export IROHA_HOME='/usr/local/iroha' && /usr/local/iroha/bin/iroha-main"
