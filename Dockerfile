# ʹ�����µ�Python�ٷ�������3.13�����ã����滻Ϊ��Ч�汾��3.11��
FROM python:3.13-slim

# ����ʱ�������Ļ�������ѡ��
ENV TZ=Asia/Shanghai \
    PYTHONUNBUFFERED=1

# ��װϵͳ����
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

# �����廪����Դ
RUN pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple

# ��װPython�������ֲ���װȷ���ȶ��ԣ�
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

# ������װPyTorch CPU�汾
RUN pip install --no-cache-dir \
    torch torchvision \
    --index-url https://download.pytorch.org/whl/cpu

# ���ù���Ŀ¼
WORKDIR /var/app
COPY . .

# ����Ӧ��
CMD ["python", "main.py"]