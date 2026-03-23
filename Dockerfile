FROM ghcr.io/openclaw/openclaw:main

USER root

# 安装 Nginx
RUN apt-get update && apt-get install -y nginx && rm -rf /var/lib/apt/lists/*

# 复制你之前创建的 nginx.conf
COPY nginx.conf /etc/nginx/nginx.conf

# 启动 Nginx 后，以 exec 方式运行主程序
# 如果你确定是用 node 启动，就用下面这一行
CMD nginx && exec /usr/local/bin/node /app/index.js
