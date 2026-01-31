from .base import *

# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = True

# Fast password hasher for testing
PASSWORD_HASHERS = [
    "django.contrib.auth.hashers.MD5PasswordHasher",
]

# Use in-memory email backend for tests
EMAIL_BACKEND = "django.core.mail.backends.locmem.EmailBackend"

# Disable whitenoise for tests
INSTALLED_APPS = [
    app for app in INSTALLED_APPS if app != "whitenoise.runserver_nostatic"
]

# Use SQLite for tests if TEST_DB is set
if env.bool("TEST_USE_SQLITE", default=False):
    DATABASES = {
        "default": {
            "ENGINE": "django.db.backends.sqlite3",
            "NAME": ":memory:",
        }
    }
