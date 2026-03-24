# 依然基于官方镜像
FROM ghcr.io/openclaw/openclaw:main

# 1. 切换回 root 权限来安装 Nginx 和修改配置
USER root

# 2. 安装 Nginx 并清理缓存
RUN apt-get update && \
    apt-get install -y --no-install-recommends nginx && \
    rm -rf /var/lib/apt/lists/*

# 3. 复制你的 Nginx 配置文件
COPY nginx.conf /etc/nginx/nginx.conf

# 4. 关键：修正启动命令
# 官方原命令是 node openclaw.mjs gateway --allow-unconfigured
# 我们在前面加上 Nginx
CMD ["sh", "-c", "nginx -g 'daemon off;' & node openclaw.mjs gateway --allow-unconfigured"]
