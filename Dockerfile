# 1. 设定地基：使用 OpenClaw 官方镜像
FROM ghcr.io/openclaw/openclaw:main

# 2. 切换到 root 权限进行安装
USER root

# 3. 安装 Nginx 并清理无用文件（减小体积）
RUN apt-get update && \
    apt-get install -y --no-install-recommends nginx && \
    rm -rf /var/lib/apt/lists/*

# 4. 复制你之前创建好的 nginx.conf 配置文件
COPY nginx.conf /etc/nginx/nginx.conf

# 5. 确保 OpenClaw 主程序有执行权限
RUN chmod +x /openclaw

# 6. 核心启动命令：先启动 Nginx，再启动 OpenClaw
# 这样你访问主域名时，Nginx 就会自动帮你转发到 Canvas 界面
CMD ["sh", "-c", "nginx && /openclaw"]
