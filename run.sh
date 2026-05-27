#!/usr/bin/env bash
set -e

if [ -f /data/params ]; then
    set -a
    # shellcheck disable=SC1091
    source /data/params
    set +a
fi

export MONGO_URL="${MONGO_URL:-mongodb://mongodb:27017/orders}"
export AMQP_HOST="${AMQP_HOST:-rabbitmq}"
export AMQP_USER="${AMQP_USER:-guest}"
export AMQP_PASS="${AMQP_PASS:-guest}"
export SHIPPING_URL="${SHIPPING_URL:-http://${SHIPPING_HOST:-roboshop-shipping}:${SHIPPING_PORT:-8080}}"
export NOTIFICATION_URL="${NOTIFICATION_URL:-http://notification:8080}"
export PORT="${PORT:-8080}"

exec java -jar orders.jar
