_SECRET_KEY = 'change_me'
_DEBUG = True
_ALLOWED_HOSTS = ['*']
_SITE_ID = 1
_CMS_TEMPLATES =  (
    ## Customize this
    ('base.html', 'Base'),
    ('cms_menu.html', 'CMS Menu'),
    ('fullwidth.html', 'Fullwidth'),
    ('sidebar_left.html', 'Sidebar Left'),
    ('sidebar_right.html', 'Sidebar Right')
)

# As needed:
#_CACHES = {
#    'default': {
#        'BACKEND': 'django.core.cache.backends.memcached.MemcachedCache',
#        'LOCATION': 'frontera_portal_memcached:11211',
#    }
#}


_DATABASE_ENGINE = 'django.db.backends.postgresql'
_DATABASE_NAME = 'postgres'
_DATABASE_USERNAME = 'postgres'
_DATABASE_PASSWORD = 'secretpw'
_DATABASE_HOST = 'postgres_host'
_DATABASE_PORT = 5432