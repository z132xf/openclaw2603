FROM ghcr.io/openclaw/openclaw:main

USER root

RUN apt-get update && apt-get install -y nginx && rm -rf /var/lib/apt/lists/*

COPY nginx.conf /etc/nginx/nginx.conf

# 用 shell 同时启动 nginx + 原程序
CMD nginx & exec /usr/bin/dumb-init -- "$@"
