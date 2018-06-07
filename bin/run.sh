#!/bin/bash

# Set environment options to exit immediately if a non-zero status code
# appears from a command or within a pipe
set -o errexit
set -o pipefail

# Send out Slack notifications (off for now)
# invoke notify

cd fec
# Run migrations
./manage.py makemigrations
./manage.py migrate --fake home
./manage.py migrate --noinput

# Run application
gunicorn -k gevent -w 2 fec.wsgi:application
