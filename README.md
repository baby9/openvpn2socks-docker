
Docker image of an OpenVPN client tied to a SOCKS proxy server.

## Usage

```
docker run -d \
  --restart=unless-stopped \
  --name=ovpn2socks \
  --cap-add=NET_ADMIN \
  --device=/dev/net/tun \
  --publish 10800:10800 \
  --volume /openvpn/directory/config.ovpn:/ovpn.conf:ro \
  zenexas/openvpn-client-socks
```

SOCKS5 proxy server will be listening at port 10800.

<br/><br/>
Connect to your socks5 proxy. For example:

````
curl -s -x socks5://127.0.0.1:10800 https://ipinfo.io
````
