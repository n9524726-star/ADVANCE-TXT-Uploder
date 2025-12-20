FROM python:3.10-slim-bullseye

# System dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    libffi-dev \
    ffmpeg \
    aria2 \
    ca-certificates \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# App directory
WORKDIR /app

# Copy files
COPY . /app

# Python dependencies
RUN pip install --no-cache-dir -r requirements.txt
RUN pip install --no-cache-dir pytube

# Env
ENV COOKIES_FILE_PATH=youtube_cookies.txt
ENV PYTHONUNBUFFERED=1

# Run only telegram bot
CMD gunicorn app:app --bind 0.0.0.0:8080 & python3 main.py
#CMD ["python3", "main.py"]
