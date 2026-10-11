#!/bin/sh
set -eu

set -- \
  -H "${DOH_HOSTNAME:?请设置 DOH_HOSTNAME}" \
  -u "${DOH_SERVER_ADDRESS:-9.9.9.9:53}" \
  -l "${DOH_LISTEN_ADDRESS:-0.0.0.0:3000}" \
  -p "${DOH_PATH:-/dns-query}"

if [ -n "${DOH_PUBLIC_ADDRESS:-}" ]; then
  set -- "$@" -g "$DOH_PUBLIC_ADDRESS"
fi

if [ -n "${DOH_PUBLIC_PORT:-}" ]; then
  set -- "$@" -j "$DOH_PUBLIC_PORT"
fi

if [ -n "${DOH_TLS_CERT_PATH:-}" ]; then
  set -- "$@" -i "$DOH_TLS_CERT_PATH"
fi

if [ -n "${DOH_TLS_CERT_KEY_PATH:-}" ]; then
  set -- "$@" -I "$DOH_TLS_CERT_KEY_PATH"
fi

if [ -n "${DOH_MAX_CLIENTS:-}" ]; then
  set -- "$@" -c "$DOH_MAX_CLIENTS"
fi

if [ -n "${DOH_MAX_CONCURRENT:-}" ]; then
  set -- "$@" -C "$DOH_MAX_CONCURRENT"
fi

if [ -n "${DOH_TIMEOUT:-}" ]; then
  set -- "$@" -t "$DOH_TIMEOUT"
fi

exec doh-proxy "$@"