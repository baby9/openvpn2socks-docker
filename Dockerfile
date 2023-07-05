# OpenVPN client + SOCKS proxy
# Usage:
# Create configuration (.ovpn), mount it in a volume
# docker run --volume=something.ovpn:/ovpn.conf:ro --device=/dev/net/tun --cap-add=NET_ADMIN
# Connect to (container):1080
# Note that the config must have embedded certs
# See `start` in same repo for more ideas

FROM alpine:3.17

COPY sockd.sh /usr/local/bin/

RUN true && \
    apk add --update --no-cache dante-server openvpn bash openresolv openrc curl && \
    rm -rf /var/cache/apk/* && \
    chmod a+x /usr/local/bin/sockd.sh

HEALTHCHECK --interval=60s --timeout=15s \
			--start-period=120s \
			CMD curl -L 'https://www.cloudflare.com/cdn-cgi/trace'

COPY sockd.conf /etc/
COPY update-resolv-conf.sh /etc/openvpn/
RUN chmod +x /etc/openvpn/update-resolv-conf.sh

EXPOSE 10800

ENTRYPOINT [ \
    "openvpn", \
    "--up", "/usr/local/bin/sockd.sh", \
    "--script-security", "2", \
    "--config", "/ovpn.conf"]
