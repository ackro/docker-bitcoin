#!/bin/sh
set -e

DAEMON=bitcoind
DATA_DIR=$HOME/.bitcoin
CONF=$DATA_DIR/bitcoin.conf
PID_FILE=$HOME/$DAEMON.pid
PORT=11775
RPC_PORT=9910
RPC_BIND=127.0.0.1

# set up datadir and some shell aliases
mkdir -p "$DATA_DIR"

# generate RPC connection parameters and credentials for cli use
if [ ! -e "$CONF" ]; then
    RPCUSER=$(</dev/urandom tr -dc a-zA-Z0-9 | head -c 10)
    RPCPASS=$(</dev/urandom tr -dc "a-zA-Z0-9!@#%^*,." | head -c 35)
    cat <<END > $CONF
rpcallowip=$RPC_BIND
rpcport=$RPC_PORT
rpcbind=$RPC_BIND
rpcconnect=$RPC_BIND
rpcuser=$RPCUSER
rpcpassword=$RPCPASS
END
fi

# check for any -paramters and pass them on
if [ "$(echo ${1} | cut -c1)" = "-" ]; then
    set -- "${DAEMON}" "$@"
fi

# add daemon startup parameters
if [ "$(echo ${1} | cut -c1)" = "-" ] || [ "${1}" = "${DAEMON}" ]; then
  set -- "$@" \
    -listen=1 \
    -logtimestamps=1 \
    -maxconnections=256 \
    -pid="${PID_FILE}" \
    -printtoconsole \
    -port=${PORT} \
    -server=1
fi

# run daemon
if [ "$1" = "${DAEMON}" ]; then
  exec "$@"
fi
