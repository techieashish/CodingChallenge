#!/bin/bash

echo "Collect static files"

python manage.py collectstatic --noinput

echo "Apply database migrations"
python manage.py migrate

echo "Starting server"
gunicorn -b 0.0.0.0:8000 --workers=2 --threads=4 --worker-class=gthread django_docker.wsgi