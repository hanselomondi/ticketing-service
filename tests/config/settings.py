"""Test configuration settings."""

import os

ENVIRONMENT = "test"
DEBUG = False
ALLOWED_HOSTS = ["*"]
DATABASES = {
    "default": {
        "ENGINE": "django.db.backends.postgresql",
        "NAME": os.getenv("DB_NAME", "ticketing_service_db"),
        "USER": os.getenv("DB_USER", "app"),
        "PASSWORD": os.getenv("DB_PASSWORD", "app"),
        "HOST": os.getenv("DB_HOST", "localhost"),
        "PORT": os.getenv("DB_PORT", "5432"),
    }
}
