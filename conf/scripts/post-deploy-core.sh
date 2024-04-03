#!/bin/bash
docker exec portal_django  python manage.py migrate
docker exec portal_django python manage.py collectstatic -c --noinput
docker restart designsafe_django
