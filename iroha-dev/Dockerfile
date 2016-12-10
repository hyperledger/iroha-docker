#-----------------------------------------------------------------------
# iroha-dev - IROHA development container
#
# build : docker build -t soramitsu/iroha-dev .
#
# Copyright (c) 2016 Soramitsu,Co.,Ltd.
# All Rights Reserved.
#-----------------------------------------------------------------------
FROM soramitsu/iroha-base

MAINTAINER Takeshi Yonezu <yonezu@soramitsu.co.jp>

LABEL BUILD="docker build -t soramitsu/iroha-dev ."
LABEL RUN="docker run -d --name iroha soramitsu/iroha-dev"

USER root

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
ENV IROHA_HOME /opt/iroha

WORKDIR /opt
RUN git clone https://github.com/hyperledger/iroha.git

WORKDIR $IROHA_HOME
RUN git submodule update --init --recursive

RUN apt -y install autoconf automake libtool pkg-config

WORKDIR /tmp
RUN git clone -b v3.0.0 https://github.com/google/protobuf.git

WORKDIR /tmp/protobuf
RUN (git cherry-pick 1760feb621a913189b90fe8595fffb74bce84598; echo Force continue) && \
  ./autogen.sh && \
  ./configure --prefix=/usr && \
  make -j 14 && \
  make install

WORKDIR /tmp
RUN git clone -b $(curl -L http://grpc.io/release) https://github.com/grpc/grpc

WORKDIR /tmp/grpc
RUN git submodule update --init && \
  make && \
  make install

WORKDIR $IROHA_HOME/core/vendor/leveldb
RUN make
WORKDIR $IROHA_HOME/core/vendor/ed25519
RUN make
WORKDIR $IROHA_HOME/core/vendor/KeccakCodePackage
RUN make && make generic64/libkeccak.a
WORKDIR $IROHA_HOME/core/infra/crypto
RUN make

RUN mkdir $IROHA_HOME/build
WORKDIR $IROHA_HOME/build
RUN cmake ..
RUN make

ENV IROHA_HOME /usr/local/iroha
ENV IROHA_SCRIPTS ${IROHA_HOME}/scripts
RUN mkdir -p ${IROHA_SCRIPTS}

ADD ./img-scripts/init-volume.sh ${IROHA_SCRIPTS}
ADD ./img-scripts/run-iroha.sh ${IROHA_SCRIPTS}
ADD ./img-scripts/test.sh ${IROHA_SCRIPTS}
ADD ./img-scripts/mkiroha-tar.sh ${IROHA_SCRIPTS}
ADD ./img-scripts/update-binaries.sh ${IROHA_SCRIPTS}

RUN sed -i 's|/opt/iroha|/usr/local/iroha|' /home/iroha/.bashrc && \
    sed -i 's|/opt/iroha|/usr/local/iroha|' /root/.bashrc

VOLUME $IROHA_HOME
VOLUME /mnt/iroha

WORKDIR $IROHA_HOME
CMD ["/bin/bash"]
