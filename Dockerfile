FROM nvidia/cuda:11.8.0-cudnn8-runtime-ubuntu22.04

ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /app


# Ensure Python 3 + pip are explicitly installed and stable
RUN apt-get update && \
    apt-get install -y git python3 python3-pip && \
    python3 -m pip install --upgrade pip
    
RUN pip install --break-system-packages \
    numpy==1.26.4 \
    pillow==10.3.0 \
    requests==2.31.0 \
    protobuf==4.25.3 \
    google-auth==2.29.0 \
    huggingface_hub==0.19.4 \
    fsspec==2024.3.1 \
    gcsfs==2024.3.1 \
    torch==2.3.0+cu118 \
    torchvision==0.17.0+cu118 \
    torchaudio==2.3.0+cu118 \
    diffusers[torch]==0.28.0 \
    transformers==4.41.2 \
    accelerate==0.31.0 \
    tqdm==4.66.5 \
    peft==0.7.1 \
    bitsandbytes==0.43.1 \
    fastapi==0.111.0 \
    uvicorn[standard]==0.30.1 \
    python-multipart==0.0.9

COPY requirements.txt .
RUN python3 -m pip install -r requirements.txt

COPY entrypoint.py .

CMD ["uvicorn", "entrypoint:app", "--host", "0.0.0.0", "--port", "8000"]

