###### 构建 ######
FROM caddy:2.6.4-builder-alpine AS builder

RUN xcaddy build \
  --with github.com/caddy-dns/dnspod

###### 镜像 ######
FROM caddy:2.6.4-alpine

# 默认中国时区
ENV TZ=Asia/Shanghai

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
