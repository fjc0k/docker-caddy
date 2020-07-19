# docker-caddy

Web 服务器 Caddy 2 的 Docker 镜像。

-----

<!-- TOC depthFrom:2 -->

- [特性](#特性)
  - [支持设置时区](#支持设置时区)
  - [支持 DNSPod](#支持-dnspod)
  - [内置安全相关的 HTTP 响应头](#内置安全相关的-http-响应头)
  - [支持使用 host.docker.internal 访问宿主服务](#支持使用-hostdockerinternal-访问宿主服务)
  - [支持通过环境变量 OCSP_IP 设置 ocsp.int-x3.letsencrypt.org 的 IP 地址](#支持通过环境变量-ocsp_ip-设置-ocspint-x3letsencryptorg-的-ip-地址)
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

### 支持使用 host.docker.internal 访问宿主服务

```ini
# Caddyfile

api.foo.bar {
  import dnspod
  import security

  reverse_proxy host.docker.internal:4000
}
```

### 支持通过环境变量 OCSP_IP 设置 ocsp.int-x3.letsencrypt.org 的 IP 地址

具体讨论见「[国内 Let's Encrypt 的 OCSP 域名 ocsp.int-x3.letsencrypt.org 的解析被污染了？](https://www.v2ex.com/t/658605)」，其表现就像这样：

> [WARNING] Stapling OCSP: no OCSP stapling for [*.com]: making OCSP request: Post http://ocsp.int-x3.letsencrypt.org: dial tcp 88.191.249.182:80: i/o timeout

因此，本镜像支持通过环境变量 `OCSP_IP` 设置 `ocsp.int-x3.letsencrypt.org` 解析去的 IP，当然，这个 IP 内置了一个默认值 `23.215.132.184`，但其可能会变，如果无法使用，可使用国外的服务器 ping 一下 `ocsp.int-x3.letsencrypt.org` 获取最新的 IP 后覆盖掉默认值。

推荐一个国外的在线 ping 服务：[https://check-host.net/check-ping?host=ocsp.int-x3.letsencrypt.org](https://check-host.net/check-ping?host=ocsp.int-x3.letsencrypt.org)

## 许可

Jay Fong (c) MIT
