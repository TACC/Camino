#! /bin/sh
mkdir -p /etc/letsencrypt/renewal-hooks/post/
echo -e "#! /bin/sh\n${DOCKER_COMPOSE} restart nginx\n" > /etc/letsencrypt/renewal-hooks/post/post-renew.sh
chmod +x /etc/letsencrypt/renewal-hooks/post/post-renew.sh
