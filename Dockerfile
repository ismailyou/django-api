FROM python:3.10-alpine

LABEL   maintainer="jadid.ismail.tdi@gmail.com"
LABEL   description="a simple python web app using django web api"

# set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Copy the current directory contents into the container at /app
COPY ./requirements.txt /tmp/requirements.txt
COPY ./app /app

# set work directory
WORKDIR /app

EXPOSE 8000

#ARG DEV=false

RUN pip install --upgrade pip \
    && apk add --update postgresql-client \
    && apk add --no-cache --virtual .tmp-build-deps build-base postgresql-dev musl-dev \
    && pip install -r /tmp/requirements.txt \
    && rm -rf /tmp \
    && apk del .tmp-build-deps \
    && adduser --disabled-password --no-create-home user

USER user
