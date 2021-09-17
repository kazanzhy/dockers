import os
from pathlib import Path

FILE_DIR = Path(__file__).parent.absolute()
BASE_DIR = os.environ.get('SUPERSET_HOME', str(FILE_DIR))


#------------------------------------------------------------------------------------------------------------------
# Superset specific config
ROW_LIMIT = 5000
SUPERSET_WEBSERVER_PORT = 8088
SUPERSET_WEBSERVER_TIMEOUT = 300

#------------------------------------------------------------------------------------------------------------------
# Superset cache config
CACHE_CONFIG = {
    'CACHE_TYPE': 'redis',
    'CACHE_DEFAULT_TIMEOUT': 60 * 60 * 2, # 2 hours (in secs)
    'CACHE_KEY_PREFIX': 'superset_',
    'CACHE_REDIS_URL': 'redis://redis:6379/',
}

#------------------------------------------------------------------------------------------------------------------
# Database configuration
# The SQLAlchemy connection string to your database backend
SQLALCHEMY_DATABASE_URI = "postgresql+psycopg2://superset:superset@postgres:5432/superset"

#------------------------------------------------------------------------------------------------------------------
# Security and access
PUBLIC_ROLE_LIKE = 'Gamma'

#------------------------------------------------------------------------------------------------------------------
# Flask App Builder configuration
# Your App secret key
SECRET_KEY = '\2\1ThisIsMyScretKey\1\2\e\y\y\h'
# Flask-WTF flag for CSRF
WTF_CSRF_ENABLED = True
# Add endpoints that need to be exempt from CSRF protection
WTF_CSRF_EXEMPT_LIST = []
# A CSRF token that expires in 1 year
WTF_CSRF_TIME_LIMIT = 60 * 60 * 24 * 365
# Set this API key to enable Mapbox visualizations
MAPBOX_API_KEY = 'pk.eyJ1Ijoia2F6YW56aHkiLCJhIjoiY2s5eWVpaThzMDg2YjNydDdhMnR5amtqciJ9.JLZlpjI0YcZv4aGLIm31PA'

#------------------------------------------------------------------------------------------------------------------
# Email Reports
EMAIL_NOTIFICATIONS = False
SMTP_HOST = "smtp.gmail.com"
SMTP_STARTTLS = True
SMTP_SSL = True
SMTP_USER = "superset"
SMTP_PORT = 465
SMTP_PASSWORD = "OX9JOxNY5HWigwOy0Q8V"
SMTP_MAIL_FROM = "superset@gmail.com"