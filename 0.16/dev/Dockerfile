#
# Bitcoin Core library & headers for Alpine Linux
#
FROM hub.ackro.net/bitcoin:0.16-build-alpine as build
FROM ackro/libdb:4.8-dev-alpine

COPY --from=build /usr/local/src/bitcoin/build/include /usr/local/include/
COPY --from=build /usr/local/src/bitcoin/build/lib /usr/local/lib/
RUN apk add --no-cache boost-dev libevent-dev openssl-dev
