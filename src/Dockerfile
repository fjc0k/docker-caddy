###### 构建 ######
FROM caddy:2.0.0-builder AS builder

RUN caddy-builder \
  # https://github.com/caddy-dns/lego-deprecated#%EF%B8%8F-this-module-is-deprecated
  # https://go-acme.github.io/lego/dns/dnspod/
  # 暂时使用 lego-deprecated 实现
  github.com/caddy-dns/lego-deprecated


###### 镜像 ######
FROM caddy:2.0.0

# 默认中国时区
ENV TZ=Asia/Shanghai
# https://go-acme.github.io/lego/dns/dnspod/#additional-configuration
ENV DNSPOD_HTTP_TIMEOUT=10000

RUN \
  # 在根目录引用 /etc/caddy/Caddyfile 以让 caddy 相关命令自动发现
  echo "import /etc/caddy/Caddyfile" > /Caddyfile && \
  # 安装 tzdata 以使用 TZ 环境变量设置时区
  apk add --no-cache --update tzdata

WORKDIR /

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
COPY ./snippets/dnspod /etc/caddy/dnspod
COPY ./snippets/security /etc/caddy/security
COPY ./entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
