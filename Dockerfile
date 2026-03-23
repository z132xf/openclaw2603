FROM ghcr.io/openclaw/openclaw:main

USER root

RUN apt-get update && apt-get install -y nginx && rm -rf /var/lib/apt/lists/*

COPY nginx.conf /etc/nginx/nginx.conf

# 启动 nginx，同时保持容器不退出（让原 ENTRYPOINT 工作）
CMD ["sh", "-c", "nginx && tail -f /dev/null"]
