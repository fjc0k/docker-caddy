# docker-caddy

Web 服务器 Caddy 2 的 Docker 镜像。

-----

<!-- TOC depthFrom:2 -->

- [特性](#特性)
  - [支持设置时区](#支持设置时区)
  - [支持 DNSPod](#支持-dnspod)
  - [内置安全相关的 HTTP 响应头](#内置安全相关的-http-响应头)
- [许可](#许可)

<!-- /TOC -->

## 特性

与官方镜像 [caddyserver/caddy-docker](https://github.com/caddyserver/caddy-docker) 相比，做了一些符合中国用户使用习惯的增强，主要有以下几点：

### 支持设置时区

你可通过环境变量 `TZ` 设置时区，若不设置，默认是：`Asia/Shanghai`。

### 支持 DNSPod

支持使用 [DNSPod](https://www.dnspod.cn/) 作为 DNS 提供者，并内置 [`dnspod`](https://github.com/fjc0k/docker-caddy/blob/master/src/snippets/dnspod) 片段方便导入：

```ini
# Caddyfile

www.foo.bar {
  import dnspod

  respond "hello caddy"
}
```

**注意：** 使用这项功能之前，你得先通过环境变量 `DNSPOD_API_KEY` 设置 DNSPod 的鉴权信息，格式是 `ID,Token`，比如 `10086,1b68f307ee4e5adb10od31d4d4v42dla`。

### 内置安全相关的 HTTP 响应头

全部安全相关的 HTTP 响应头皆提取自 [helmetjs/helmet](https://github.com/helmetjs/helmet#how-it-works) 的默认设置，你可通过内置的 [`security`](https://github.com/fjc0k/docker-caddy/blob/master/src/snippets/security) 片段导入：

```ini
# Caddyfile

www.foo.bar {
  import dnspod
  import security

  respond "hello caddy"
}
```


## 许可

Jay Fong (c) MIT
