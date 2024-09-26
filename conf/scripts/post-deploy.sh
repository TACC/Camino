#!/bin/bash
service=$1

if [[ "$service" == *"core"* ]] || [[ "$service" == "all" ]]; then
  docker exec portal_django python3 manage.py migrate
  docker exec portal_django python3 manage.py collectstatic --noinput --clear
fi

if [[ "$service" == *"cms"* ]] || [[ "$service" == "all" ]]; then
  docker exec portal_cms python3 manage.py migrate
  docker exec portal_cms python3 manage.py collectstatic --noinput --clear
fi