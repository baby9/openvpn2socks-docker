#!/bin/bash
set -e
/etc/openvpn/update-resolv-conf.sh "$@"
/usr/sbin/sockd -D
