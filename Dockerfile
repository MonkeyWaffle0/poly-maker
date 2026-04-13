FROM python:3.11-slim

ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PIP_NO_CACHE_DIR=1

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        git \
    && rm -rf /var/lib/apt/lists/*

COPY pyproject.toml README.md ./
COPY poly_data ./poly_data
COPY poly_stats ./poly_stats
COPY poly_utils ./poly_utils
COPY data_updater ./data_updater
RUN pip install --upgrade pip && pip install .

COPY . .

CMD ["python", "update_markets.py", "--check"]
