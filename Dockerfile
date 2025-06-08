# 使用最新的Python官方镜像（若3.13不可用，请替换为有效版本如3.11）
FROM python:3.13-slim

# 设置时区和中文环境（可选）
ENV TZ=Asia/Shanghai \
    PYTHONUNBUFFERED=1

# 安装系统依赖
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    libssl-dev \
    libffi-dev \
    libgl1-mesa-glx \
    libglib2.0-0 \
    libsm6 \
    libxrender1 \
    libxext6 \
    && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone \
    && rm -rf /var/lib/apt/lists/*

# 配置清华镜像源
RUN pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple

# 安装Python依赖（分步安装确保稳定性）
RUN pip install --no-cache-dir \
    numpy \
    Pillow \
    tqdm \
    httpx \
    httpx[http2] \
    matplotlib \
    fastapi \
    uvicorn \
    opencv-python-headless \
    cryptography \
    onnxruntime

# 单独安装PyTorch CPU版本
RUN pip install --no-cache-dir \
    torch torchvision \
    --index-url https://download.pytorch.org/whl/cpu

# 设置工作目录
WORKDIR /var/app
COPY . .

# 运行应用
CMD ["python", "main.py"]