FROM ubuntu:22.04

# 防止交互
ENV DEBIAN_FRONTEND=noninteractive

# 设置工作目录
WORKDIR /app

# 把项目里的二进制复制进镜像
COPY bin/timecron /app/timecron

# 确保执行权限（即使你本地已经 chmod 了，这是安全写法）
RUN chmod +x /app/timecron

# 启动时前台直接运行
ENTRYPOINT ["/app/timecron"]
