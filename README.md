# Dcokerfiles for IROHA

[IROHA](http://iroha.tech/) is a simple Distributed Ledger Technology software.

1. iroha-base
1. iroha-dev
1. iroha-build

Also, [iroha-build](iroha-build/) contains building scripts for IROHA on your non dockernized environment.

## 1. iroha-base

This container based on Ubuntu 16.04 and contains project dependencies.

``` bash
./build
```

## 2. iroha-dev

This container based on iroha-base image and is used for project development and testing.

``` bash
./build
```

1) cd iroha-docker/iroha-dev  
1) Set the project host directory params.sh.  
2) Init the data container ./utils-scripts/init-volume.sh  
3) Set your user as owner of the host directory: chown -R USER_NAME ./IROHA_HOST_DIR

You can make changes in your local file system and then build:  
1) ./utils-scripts/bash.sh  
2) cd /mnt/iroha/build && make

Run ./utils-scripts/update-binaries.sh to update after build.
You can now test with ./utils-scripts/run-iroha.sh -f 1 -l 4 (To run four instances of indecies 1 to 4).
