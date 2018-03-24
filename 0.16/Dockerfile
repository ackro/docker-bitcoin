#
# Bitcoin Core for Alpine Linux
#
FROM hub.ackro.net/bitcoin:0.16-build-alpine as build
FROM hub.ackro.net/bitcoin:0.16-base-alpine
ARG NAME=bitcoin
ARG DAEMON=bitcoind
ARG PORT=11775
ARG VERSION=0.16.0

COPY --from=build /usr/local/src/${NAME}/build /usr/local/
COPY entrypoint.sh /entrypoint.sh
RUN adduser -D -g '' -s /sbin/nologin ${NAME}
WORKDIR /home/${NAME}
USER ${NAME}

EXPOSE $PORT
VOLUME ["/home/${NAME}"]
ENTRYPOINT ["/entrypoint.sh"]

CMD ["${DAEMON}"]
