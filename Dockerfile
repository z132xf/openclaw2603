FROM ghcr.io/openclaw/openclaw:main

USER root

# 顺便把 dumb-init 也装了，以防万一
RUN apt-get update && apt-get install -y nginx dumb-init && rm -rf /var/lib/apt/lists/*

COPY nginx.conf /etc/nginx/nginx.conf

# 启动 Nginx 后，用 dumb-init 护航启动主程序
CMD nginx & exec /usr/bin/dumb-init -- "$@"
