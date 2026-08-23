FROM python:3.12-slim AS runtime

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1

WORKDIR /app

RUN addgroup --system lz && adduser --system --ingroup lz lz

COPY pyproject.toml README.md ./
COPY lz ./lz
RUN pip install --upgrade pip && pip install .

USER lz
EXPOSE 8080

CMD ["uvicorn", "lz.api:app", "--host", "0.0.0.0", "--port", "8080", "--proxy-headers"]
