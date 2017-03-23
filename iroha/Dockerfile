#-----------------------------------------------------------------------
# iroha - IROHA container
#
# build : docker build -t hyperledger/iroha .
#
# Copyright (c) 2016, 2017 Soramitsu,Co.,Ltd.
# All Rights Reserved.
#-----------------------------------------------------------------------
FROM hyperledger/iroha-dev

MAINTAINER Takeshi Yonezu <yonezu@soramitsu.co.jp>

USER root

ARG BRANCH=${BRANCH:-master}
RUN echo "IROHA clone branch: ${BRANCH}"

LABEL GIT="git clone -b ${BRANCH} --recursive https://github.com/hyperledger/iroha.git iroha"
LABEL BUILD="docker build --build-arg BRANCH=${BRANCH} -t hyperledger/iroha ."
LABEL RUN="docker run -d --name iroha hyperledger/iroha"

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
ENV JAVA_INCLUDE $JAVA_INCLUDE:${JAVA_HOME}/include/linux/
ENV IROHA_HOME /opt/iroha
ENV IROHA_DEST /usr/local/iroha

WORKDIR /opt
RUN git clone -b ${BRANCH} --recursive https://github.com/hyperledger/iroha.git iroha; \
    apt -y install autoconf automake libtool pkg-config

WORKDIR /tmp
RUN git clone -b v3.0.0 https://github.com/google/protobuf.git

WORKDIR /tmp/protobuf
RUN (git cherry-pick 1760feb621a913189b90fe8595fffb74bce84598; echo Force continue) && \
  ./autogen.sh && \
  ./configure --prefix=/usr && \
  make -j 16 && \
  make install

WORKDIR /tmp
RUN git clone -b $(curl -L http://grpc.io/release) https://github.com/grpc/grpc

WORKDIR /tmp/grpc
RUN git submodule update --init && \
  make -j 14 && \
  make install

RUN mkdir $IROHA_HOME/build
WORKDIR $IROHA_HOME/build
RUN cmake ..
RUN make

COPY ./tools/test.sh ./tools/mkiroha-tar.sh ./tools/iroha-out.sh ${IROHA_HOME}/

RUN mkdir $IROHA_DEST
RUN rsync -av bin lib $IROHA_DEST

## USER iroha
WORKDIR $IROHA_HOME

CMD /bin/su - iroha -c "env IROHA_HOME=${IROHA_HOME} ${IROHA_DEST}/bin/iroha-main"
