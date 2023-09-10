#!/usr/bin/env bash
# exit on error
set -o errexit

pip install --upgrade pip setuptools
pip install -r requirements.txt
python manage.py collectstatic --no-input
python manage.py migrate django_celery_beat
celery -A core beat -l INFO --scheduler django_celery_beat.schedulers:DatabaseScheduler &