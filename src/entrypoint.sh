#!/usr/bin/env sh

set -ex

# dockerhost
echo -e "`/sbin/ip route | awk '/default/ { print $3 }'`\thost.docker.internal" | tee -a /etc/hosts > /dev/null

echo -e "${OCSP_IP:-23.215.132.184}\tocsp.int-x3.letsencrypt.org" >> /etc/hosts

caddy run
