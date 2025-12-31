FROM nvidia/cuda:11.8.0-cudnn8-runtime-ubuntu22.04

WORKDIR /app

COPY requirements.txt .
RUN apt update && apt install -y git && pip install --upgrade pip && pip install -r requirements.txt

COPY entrypoint.py .

CMD ["uvicorn", "entrypoint:app", "--host", "0.0.0.0", "--port", "8000"]

