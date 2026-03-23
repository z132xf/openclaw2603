FROM ghcr.io/openclaw/openclaw:main

USER root

# 安装 nginx（你之前的部分）
RUN apt-get update && \
    apt-get install -y --no-install-recommends nginx && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# 安装 dumb-init（官方推荐方式，轻量二进制）
RUN apt-get update && \
    apt-get install -y wget && \
    wget -O /usr/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.5/dumb-init_1.2.5_amd64 && \
    chmod +x /usr/bin/dumb-init && \
    apt-get remove -y wget && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*

COPY nginx.conf /etc/nginx/nginx.conf

# 现在可以用 dumb-init 了
ENTRYPOINT ["dumb-init", "--"]
CMD ["sh", "-c", "nginx -g 'daemon off;' & exec /openclaw"]
