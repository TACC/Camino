# SECRET SETTINGS VALUES.
# SAMPLE.TACC.UTEXAS.EDU

########################
# DJANGO SETTINGS
########################

SECRET_KEY = 'change_me'
ALLOWED_HOSTS = ['sample.tacc.utexas.edu']
CEP_AUTH_VERIFICATION_ENDPOINT = 'https://sample.tacc.utexas.edu'

########################
# DATABASE SETTINGS
########################

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql_psycopg2',
        'PORT': '5432',
        'NAME': 'sample_cms',
        'USER': 'sample_cms',
        'PASSWORD': 'change_me',
        'HOST': 'portal_postgres'
    }
}

########################
# ELASTICSEARCH
########################

ES_HOSTS = 'https://esclient:9200'
ES_AUTH = 'sample:change_me'
ES_INDEX_PREFIX = 'sample-{}'
ES_DOMAIN = 'https://sample.tacc.utexas.edu'

HAYSTACK_CONNECTIONS = {
    'default': {
        'ENGINE': 'haystack.backends.elasticsearch_backend.ElasticsearchSearchEngine',
        'URL': ES_HOSTS,
        'INDEX_NAME': ES_INDEX_PREFIX.format('cms'),
        'KWARGS': {'http_auth': ES_AUTH }
    }
}
