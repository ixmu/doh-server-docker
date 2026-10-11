FROM debian:bookworm-slim

ARG VERSION
ARG TARGETARCH

RUN apt-get update \
    && apt-get install -y --no-install-recommends ca-certificates curl bzip2 \
    && case "${TARGETARCH}" in \
         amd64) upstream_arch="x86_64" ;; \
         arm64) upstream_arch="aarch64" ;; \
         *) echo "Unsupported architecture: ${TARGETARCH}" >&2; exit 1 ;; \
       esac \
    && curl -fsSL \
       "https://github.com/DNSCrypt/doh-server/releases/download/${VERSION}/doh-proxy_${VERSION}_linux-${upstream_arch}.tar.bz2" \
       -o /tmp/doh-proxy.tar.bz2 \
    && mkdir -p /tmp/doh-proxy \
    && tar -xjf /tmp/doh-proxy.tar.bz2 -C /tmp/doh-proxy \
    && install -m 0755 "$(find /tmp/doh-proxy -type f -name doh-proxy -print -quit)" /usr/local/bin/doh-proxy \
    && rm -rf /tmp/doh-proxy /tmp/doh-proxy.tar.bz2 \
    && apt-get purge -y --auto-remove curl bzip2 \
    && rm -rf /var/lib/apt/lists/*

EXPOSE 3000

ENTRYPOINT ["doh-proxy"]
CMD ["--help"]