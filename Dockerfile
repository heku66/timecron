FROM alpine

# 支持 glibc 风格 Go 二进制 + cgo 依赖
RUN apk add --no-cache gcompat libc6-compat libgcc wget ca-certificates

# 下载 timecron
ENV TIMECON_VERSION=1.1.0
WORKDIR /app
RUN wget -O timecron https://gitee.com/xnkyn/assets/releases/download/timecron-v1/timecron-linux-${TIMECON_VERSION} \
    && chmod +x timecron

CMD ["/app/timecron"]
