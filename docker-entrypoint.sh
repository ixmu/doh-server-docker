#!/bin/sh
set -eu

if [ -n "${DOH_TLS_CERT_PATH:-}" ] || [ -n "${DOH_TLS_CERT_KEY_PATH:-}" ]; then
  : "${DOH_TLS_CERT_PATH:?启用独立 HTTPS 时必须设置 DOH_TLS_CERT_PATH}"
  : "${DOH_TLS_CERT_KEY_PATH:?启用独立 HTTPS 时必须设置 DOH_TLS_CERT_KEY_PATH}"

  listen_address="${DOH_LISTEN_ADDRESS:-0.0.0.0:443}"
else
  listen_address="${DOH_LISTEN_ADDRESS:-0.0.0.0:3000}"
fi

set -- \
  -H "${DOH_HOSTNAME:?请设置 DOH_HOSTNAME}" \
  -u "${DOH_SERVER_ADDRESS:-9.9.9.9:53}" \
  -l "${listen_address}" \
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