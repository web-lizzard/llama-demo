ARG python_version=3.11
ARG poetry_version=1.4.2

FROM python:${python_version}-slim as poetry-export
ARG poetry_version

RUN pip install --no-cache-dir --disable-pip-version-check poetry==${poetry_version}

COPY pyproject.toml poetry.lock ./
RUN poetry export --only main  --without-hashes --no-interaction --output requirements.txt


FROM python:${python_version}-slim as runtime
ARG python_version

WORKDIR /app

COPY --from=poetry-export /requirements.txt requirements.txt
RUN pip install --no-cache-dir --disable-pip-version-check -r requirements.txt

COPY . .

ENV PYTHONUNBUFFERED=1 \
    PYTHONFAULTHANDLER=1

ENTRYPOINT ["python", "main.py"]
