FROM ghcr.io/openclaw/openclaw:main

USER root

RUN apt-get update && \
    apt-get install -y --no-install-recommends nginx && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY nginx.conf /etc/nginx/nginx.conf

# 验证 nginx 配置（可选，但推荐）
RUN nginx -t

# 直接并行启动（后台 nginx + 前台 openclaw）
CMD ["sh", "-c", "nginx -g 'daemon off;' & exec /openclaw"]
