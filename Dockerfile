# =========================
# Build stage：编译 timecron
# =========================
FROM alpine AS builder

# 安装 Go SDK 和必要工具
RUN apk add --no-cache go git bash

# 设置 Go 环境变量
ENV GOPATH=/go
ENV PATH=$GOPATH/bin:/usr/local/go/bin:$PATH

# 创建工作目录
WORKDIR /src

# 克隆 timecron 源码
RUN git clone https://github.com/xnkyn/timecron.git timecron-src

WORKDIR /src/timecron-src

# 静态编译 timecron
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o /timecron ./...

# =========================
# Final stage：最小运行镜像
# =========================
FROM alpine:3.20

# 安装 gcompat 和证书
RUN apk add --no-cache gcompat ca-certificates

# 复制编译好的 timecron
COPY --from=builder /timecron /usr/local/bin/timecron

# 设置工作目录
WORKDIR /app

# 默认启动 timecron
ENTRYPOINT ["/usr/local/bin/timecron"]
