FROM python:3.7-alpine

RUN mkdir -p /home/app

ENV HOME=/home/app
ENV APP_HOME=/home/app/web
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

RUN mkdir $APP_HOME

WORKDIR $APP_HOME

RUN apk update \
    && apk add postgresql-dev gcc python3-dev musl-dev
RUN pip install --upgrade pip

COPY . $APP_HOME
RUN pip wheel --no-cache-dir --no-deps --wheel-dir /wheels -r req.txt
RUN pip install -r req.txt



RUN python manage.py collectstatic --no-input