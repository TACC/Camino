#!/bin/bash
service=$1

if [[ -n "$(docker ps -q -f name=^/portal_django$)" && ("$service" == *"core"* || "$service" == "all") ]]; then
  echo "Running post-deploy script for portal_django..."

  docker exec portal_django python3 manage.py migrate
  docker exec portal_django python3 manage.py collectstatic --noinput --clear

  # Delete all sessions to force users to log out after deployment
  docker exec portal_django python3 manage.py shell -c "from django.contrib.sessions.models import Session; Session.objects.all().delete()"
fi

if [[ -n "$(docker ps -q -f name=^/portal_cms$)" && ("$service" == *"cms"* || "$service" == "all") ]]; then
  echo "Running post-deploy script for portal_cms..."

  docker exec portal_cms python3 manage.py migrate
  docker exec portal_cms python3 manage.py collectstatic --noinput --clear

  # Delete all sessions to force users to log out after deployment
  docker exec portal_cms python3 manage.py shell -c "from django.contrib.sessions.models import Session; Session.objects.all().delete()"
fi
