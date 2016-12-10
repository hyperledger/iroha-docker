#!/bin/bash

usage()
{
cat << EOF
usage: $0 options

This script runs a multiple instances of iroha container.

OPTIONS:
   -h      show this message
   -f      start index - integer
   -l      stop index - integer
EOF
}

checkOption()
{
        local __value=$(echo "${!1}")
        if [[ -z ${__value} ]]; then
                echo "option "${2}" is not set!"
                usage
                exit 1
        fi

        local re_integer="^[0-9]+$"
        if ! [[ ${__value} =~ $re_integer ]]; then
                echo "option "${2}" is not an integer!"
                usage
                exit 1
        fi
}

while getopts ":h:f:l:" OPTION
do
     case $OPTION in
         f)
             FIRST=${OPTARG}
             ;;
         l)
             LAST=${OPTARG}
             ;;
         *)
             usage
             exit 1
             ;;
     esac
done

checkOption FIRST f
checkOption LAST l

if [[ "$FIRST" -gt "$LAST" ]]; then
    echo "invalid indices!"
    usage
    exit 1
fi

WORKING_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
CONFIGS_DIR=$(realpath "$WORKING_DIR/../configs")

for ((INDEX=$FIRST; INDEX<=$LAST; INDEX++)); do

    echo "container number: $INDEX"
    IROHA_CONFIG="$CONFIGS_DIR/$INDEX/sumeragi.json"
    if [[ ! -f $IROHA_CONFIG ]]; then
        echo "configs directory: $CONFIGS_DIR is missing index: $INDEX"
        exit 1
    fi

    CONTAINER_NAME="iroha-${INDEX}"
    IROHA_STATUS=$(docker inspect --format="{{ .State.Running }}" $CONTAINER_NAME 2> /dev/null)
    if [[ "$IROHA_STATUS" == "true" ]]; then
        
        echo -n -e "Iroha container index-$INDEX is already running\n. Press y to restart it, or else to continue."; read RESTART
        if [[ "$RESTART" == "y" ]]; then
            docker stop $CONTAINER_NAME 2> /dev/null
            docker rm $CONTAINER_NAME 2> /dev/null
        else
            continue
        fi
    
    fi

    if [[ "IROHA_STATUS" == "false" ]]; then
        docker rm $CONTAINER_NAME 2> /dev/null
    fi
    
    #IROHA_CONFIG="$CONFIGS_DIR/$INDEX/sumeragi.json"
    #CONTAINER_NAME="iroha-${INDEX}"
    docker run --name=$CONTAINER_NAME \
               --volumes-from "iroha-data" \
               -v "${IROHA_CONFIG}:/usr/local/iroha/config" \
               -it soramitsu/iroha-dev /usr/local/iroha/scripts/run-iroha.sh
done
