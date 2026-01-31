# AGENTS.md - Guidelines for AI Coding Agents

This file provides instructions for AI agents working on this Django + Wagtail + Tailwind CSS starter project.

## Project Overview

- **Stack**: Django 5.2, Wagtail 7.2, Tailwind CSS 4.x, PostgreSQL
- **Python**: 3.10+ with uv for dependency management
- **Frontend**: Tailwind CSS with django-tailwind integration
- **Structure**: Single Django project (`config/`) with apps in root level

## Build/Lint/Test Commands

### Python/Django

```bash
# Setup (run once)
bash setup-uv.sh                 # Create venv and install deps with uv
source venv/bin/activate         # Activate venv
python manage.py tailwind install # Install Tailwind deps
bash setup-db.sh                 # Setup PostgreSQL database

# Development
python manage.py runserver       # Start Django dev server
python manage.py tailwind start  # Start Tailwind watcher (run in separate terminal)

# Database
python manage.py migrate         # Run migrations
python manage.py makemigrations  # Create migrations
python manage.py collectstatic --no-input  # Collect static files

# Testing (Django default - no pytest configured)
python manage.py test            # Run all tests
python manage.py test accounts   # Run tests for specific app
python manage.py test accounts.tests.AccountModelTest  # Run single test class
python manage.py test accounts.tests.AccountModelTest.test_method  # Run single test

# Linting & Formatting
ruff check .                     # Lint code
ruff check --fix .               # Lint and auto-fix issues
ruff format .                    # Format code
```

### Frontend (Tailwind)

```bash
cd theme/static_src

npm run dev                      # Development with watcher
npm run build                    # Production build
npm run start                    # Alias for dev
```

## Code Style Guidelines

### Python

- **Formatter**: Use `ruff format` (replaces black)
- **Linter**: Use `ruff check` (replaces pylint/pylint-django)
- **Line length**: 88 characters (configured in pyproject.toml)
- **Quotes**: Double quotes for strings
- **Imports**: Grouped by:
  1. Standard library (e.g., `import uuid`)
  2. Third-party Django/Wagtail (e.g., `from django.db import models`)
  3. Local app imports (e.g., `from .models import Account`)
- **Naming**: 
  - Classes: PascalCase (e.g., `AccountAdmin`, `CustomUserManager`)
  - Functions/variables: snake_case
  - Constants: UPPER_SNAKE_CASE
- **Docstrings**: Use triple double quotes for classes and functions

### Django-Specific

- **Apps**: Define `AppConfig` classes in `apps.py` (e.g., `AccountsConfig`)
- **Models**: 
  - Use `uuid` for unique identifiers when needed
  - Define `__str__` method for all models
  - Use `gettext_lazy` (`_`) for translatable strings
- **Settings**: 
  - Use `django-environ` for environment variables
  - Settings split across `config/settings/` (base, local, test, production, staging)
- **URL patterns**: Always end paths with trailing comma
- **Admin**: Use `list_display`, `list_filter`, `search_fields` for usability

### Tailwind/CSS

- **Config**: `theme/static_src/tailwind.config.js`
- **Entry**: `theme/static_src/src/styles.css`
- **Output**: `theme/static/css/dist/styles.css`
- **Plugins**: forms, typography, line-clamp, aspect-ratio (pre-configured)
- **Template paths**: Configured for `templates/**/*.html` patterns

### Error Handling

- Raise `ValueError` with descriptive messages in model managers
- Use Django's built-in validation where possible
- Log errors appropriately (Sentry SDK configured for production)

## Project Structure

```
config/                  # Django project settings
  settings/
    base.py             # Base settings (shared)
    local.py            # Development settings
    test.py             # Test settings
    production.py       # Production settings
    staging.py          # Staging settings
accounts/               # Custom user app
  models.py             # Account model (email-based auth)
  admin.py              # AccountAdmin configuration
  forms.py              # AccountCreationForm, AccountChangeForm
  views.py              # (empty - add views here)
  tests.py              # Tests (currently empty)
theme/                  # Tailwind CSS app
  static_src/           # Tailwind source files
    src/styles.css      # CSS entry point
    tailwind.config.js  # Tailwind configuration
    package.json        # npm scripts
static/                 # Static files (dev)
staticfiles/            # Collected static files (production)
media/                  # User-uploaded files
pyproject.toml          # Project dependencies and config (uv-based)
manage.py               # Django management script
```

## Key Dependencies

- Django 5.2.x + django-environ
- Wagtail 7.2.x (CMS)
- django-tailwind 4.2.x (CSS integration)
- psycopg2-binary 2.9.x (PostgreSQL)
- whitenoise 6.9.x (static files)
- sentry-sdk 2.22.x (error tracking)
- ruff 0.9.x (dev tools - replaces black and pylint)

## Environment Setup

Required `.env` variables:
- `SECRET_KEY`
- `ALLOWED_HOSTS` (comma-separated)
- `DB_NAME`, `DB_USER`, `DB_PASSWORD`, `DB_HOST`

See `.env.example` for template.

## Notes

- This is a starter template - under active development
- Uses uv (not pip-tools, poetry or pipenv) for dependency management
- PostgreSQL required (SQLite config commented out in base.py)
- No pytest configured - use Django's built-in test runner
- No existing Cursor rules or Copilot instructions found in repo
