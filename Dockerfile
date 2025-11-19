FROM ubuntu:22.04

# 防止交互窗口
ENV DEBIAN_FRONTEND=noninteractive

# 安装基础工具 + wget + curl
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    ca-certificates \
    && apt-get clean

# ---- 安装 Go（版本可自定义） ----
ENV GO_VERSION=1.22.5

RUN wget https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz \
    && tar -C /usr/local -xzf go${GO_VERSION}.linux-amd64.tar.gz \
    && rm go${GO_VERSION}.linux-amd64.tar.gz

# 配置 Go 环境变量
ENV PATH="/usr/local/go/bin:${PATH}"

# ---- 安装 timecron（版本可自定义） ----
# 你可以修改版本地址，例如 timecron-linux-1.1.0
ENV TIMECON_VERSION=1.1.0

WORKDIR /app

RUN wget -O timecron \
    https://gitee.com/xnkyn/assets/releases/download/timecron-v1/timecron-linux-${TIMECON_VERSION} \
    && chmod +x timecron

# 默认执行 timecron
ENTRYPOINT ["/app/timecron"]
