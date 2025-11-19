# =========================
# Build stage：下载 timecron
# =========================
FROM alpine AS builder

# 安装 wget、ca-certificates
RUN apk add --no-cache wget ca-certificates

# 设置 timecron 版本，可自定义
ENV TIMECON_VERSION=1.1.0
WORKDIR /app

# 从网络下载二进制并赋权
RUN wget -O timecron \
    https://gitee.com/xnkyn/assets/releases/download/timecron-v1/timecron-linux-${TIMECON_VERSION} \
    && chmod +x timecron


# =========================
# Final stage：最小运行镜像
# =========================
FROM alpine

# 安装 gcompat 支持 glibc 风格 Go 二进制
RUN apk add --no-cache gcompat

# 复制 timecron 二进制到最终镜像
COPY --from=builder /app/timecron /usr/local/bin/timecron

# 默认启动 timecron
CMD ["/usr/local/bin/timecron"]
