#
# Bitcoin Core build environment for Alpine Linux
#
FROM ackro/libdb:4.8-dev-alpine as db
FROM ackro/alpine-build
ARG VERSION=0.16.0

COPY --from=db /usr/local /usr/local/
RUN apk add --no-cache boost-dev libevent-dev openssl-dev

WORKDIR /usr/local/src
RUN wget https://github.com/bitcoin/bitcoin/archive/v${VERSION}.tar.gz \
  && tar -xzf v$VERSION.tar.gz \
  && rm v$VERSION.tar.gz \
  && mv bitcoin-${VERSION} bitcoin

WORKDIR /usr/local/src/bitcoin
RUN sed -i '/AC_CONFIG_MACRO_DIR/a\AR_FLAGS=cr' configure.ac \
  && sed -i '/AX_PROG_CC_FOR_BUILD/a\AR_FLAGS=cr' src/secp256k1/configure.ac \
  && sed -i '/AC_PREREQ/a\AR_FLAGS=cr' src/univalue/configure.ac \
  && sed -i s:sys/fcntl.h:fcntl.h: src/compat.h

RUN mkdir build \
  && ./autogen.sh \
  && ./configure \
    --disable-bench \
    --disable-dependency-tracking \
    --disable-static \
    --disable-tests \
    --disable-zmq \
    --prefix=/usr/local/src/bitcoin/build \
    --with-gui=no \
    --with-miniupnpc=no \
  && make -j3 \
  && make install \
  && make clean \
  && strip \
    build/bin/bitcoin-cli \
    build/bin/bitcoin-tx \
    build/bin/bitcoind \
    build/lib/libbitcoinconsensus.so.0.0.0 \
  && rm -rf build/share
