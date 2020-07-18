#!/usr/bin/env sh

set -ex

cd /

# 支持 host.docker.internal
echo -e "`/sbin/ip route | awk '/default/ { print $3 }'`\thost.docker.internal" | tee -a /etc/hosts > /dev/null

# 解决 ocsp 被污染问题
echo -e "${OCSP_IP:-23.215.132.184}\tocsp.int-x3.letsencrypt.org" >> /etc/hosts

caddy run
