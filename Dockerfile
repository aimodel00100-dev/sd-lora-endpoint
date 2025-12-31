FROM nvidia/cuda:11.8.0-cudnn8-runtime-ubuntu22.04

ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /app
RUN pip install "gcsfs[gcs]"


# Ensure Python 3 + pip are explicitly installed and stable
RUN apt-get update && \
    apt-get install -y git python3 python3-pip && \
    python3 -m pip install --upgrade pip
    

COPY requirements.txt .
RUN python3 -m pip install -r requirements.txt

COPY entrypoint.py .

CMD ["uvicorn", "entrypoint:app", "--host", "0.0.0.0", "--port", "8000"]

