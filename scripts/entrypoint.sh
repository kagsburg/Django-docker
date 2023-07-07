#!/bin/sh


set -e

# static files
python manage.py collectstatic --noinput

uwsgi --socket :8000 --master --enable-threads --module docker_test.wsgi