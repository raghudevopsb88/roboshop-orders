#!/usr/bin/env bash
set -e

if [ -f /data/params ]; then
    set -a
    # shellcheck disable=SC1091
    source /data/params
    set +a
fi

: "${MONGO_URL:?MONGO_URL is required}"
: "${AMQP_HOST:?AMQP_HOST is required}"
: "${AMQP_USER:?AMQP_USER is required}"
: "${AMQP_PASS:?AMQP_PASS is required}"
: "${SHIPPING_HOST:?SHIPPING_HOST is required}"
: "${SHIPPING_PORT:?SHIPPING_PORT is required}"
: "${PORT:?PORT is required}"

export MONGO_URL AMQP_HOST AMQP_USER AMQP_PASS PORT
export SHIPPING_URL="http://${SHIPPING_HOST}:${SHIPPING_PORT}"

exec java -jar orders.jar
