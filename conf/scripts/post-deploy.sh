#!/bin/bash
service=$1

if [[ -n "$(docker ps -q -f name=^/portal_django$)" && ("$service" == *"core"* || "$service" == "all") ]]; then
  echo "Running post-deploy script for portal_django..."

  docker exec portal_django python3 manage.py migrate
  docker exec portal_django python3 manage.py collectstatic --noinput --clear

  # Delete Tapis tokens for users who do not have an active session
  docker exec portal_django python3 manage.py shell -c "
from django.contrib.sessions.models import Session
from portal.apps.auth.models import TapisOAuthToken

users_with_active_sessions = set()
for session in Session.objects.all():
    data = session.get_decoded()
    uid = data.get('_auth_user_id')
    if uid:
        users_with_active_sessions.add(int(uid))

stale_tokens = TapisOAuthToken.objects.exclude(user_id__in=users_with_active_sessions)
for token in stale_tokens:
    print(f'Removing stale token for user: {token.user.username}')
count = stale_tokens.delete()[0]
print(f'Deleted {count} Tapis tokens for users without active sessions')
"

  # Delete all expired sessions
  docker exec portal_django python3 manage.py clearsessions
fi

if [[ -n "$(docker ps -q -f name=^/portal_cms$)" && ("$service" == *"cms"* || "$service" == "all") ]]; then
  echo "Running post-deploy script for portal_cms..."

  docker exec portal_cms python3 manage.py migrate
  docker exec portal_cms python3 manage.py collectstatic --noinput --clear

  # Delete all sessions to force users to log out after deployment
  docker exec portal_cms python3 manage.py shell -c "from django.contrib.sessions.models import Session; Session.objects.all().delete()"
fi
