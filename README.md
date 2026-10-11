# ![DoH server (and ODoH - Oblivious DoH server)](logo.png)

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![Rust](https://img.shields.io/badge/rust-%23000000.svg?style=flat&logo=rust&logoColor=white)](https://www.rust-lang.org/)
[![Crates.io](https://img.shields.io/crates/v/doh-proxy.svg)](https://crates.io/crates/doh-proxy)

A fast and secure DoH (DNS-over-HTTPS) and ODoH (Oblivious DoH) server.

`doh-proxy` is written in Rust, and has been battle-tested in production since February 2018. It doesn't do DNS resolution on its own, but can sit in front of any DNS resolver in order to augment it with DoH support.

#搭配nginx反向代理使用

```podman run -d \
  --name doh-server \
  --restart=unless-stopped \
  -p 127.0.0.1:3000:3000 \
  -e DOH_HOSTNAME=sdns.ixnic.net \
  -e DOH_SERVER_ADDRESS=8.8.8.8:53 \
  -e DOH_PATH=/dns-query \
  docker.io/xlousp/doh-server:latest
```

#独立运行DOH服务器

```podman run -d \
  --name doh-server \
  --restart=unless-stopped \
  -p 443:443 \
  -v /opt/doh-server/certs:/certs:ro,Z \
  -e DOH_HOSTNAME=sdns.ixnic.net \
  -e DOH_SERVER_ADDRESS=8.8.8.8:53 \
  -e DOH_PATH=/dns-query \
  -e DOH_TLS_CERT_PATH=/certs/fullchain.pem \
  -e DOH_TLS_CERT_KEY_PATH=/certs/privkey.pem \
  docker.io/xlousp/doh-server:latest
```