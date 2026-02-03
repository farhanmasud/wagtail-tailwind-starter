# AGENTS.md - Guidelines for AI Coding Agents

This file provides instructions for AI agents working on this Django + Wagtail + Tailwind CSS project.

## Project Overview

- **Stack**: Django 5.2, Wagtail 7.2, Tailwind CSS 3.x, PostgreSQL
- **Python**: 3.11 with uv for dependency management
- **Frontend**: Tailwind CSS with django-tailwind 4.x integration
- **Structure**: Single Django project (`config/`) with apps in root level

## Build/Lint/Test Commands

### Python/Django

```bash
bash setup-uv.sh                 # Setup venv and install deps with uv
source venv/bin/activate
python manage.py tailwind install
bash setup-db.sh                 # Setup PostgreSQL database

python manage.py runserver       # Start Django dev server
python manage.py tailwind start  # Start Tailwind watcher (separate terminal)

python manage.py migrate
python manage.py makemigrations
python manage.py collectstatic --no-input

python manage.py test            # Run all tests
python manage.py test accounts   # Run tests for specific app
python manage.py test accounts.tests.AccountModelTest  # Run test class
python manage.py test accounts.tests.AccountModelTest.test_method  # Run single test

ruff check .                     # Lint code
ruff check --fix .               # Lint and auto-fix
ruff format .                    # Format code

djlint templates/ --check        # Check template formatting
djlint templates/ --reformat     # Format templates
```

### Frontend (Tailwind)

```bash
cd theme/static_src

npm run dev                      # Development with watcher
npm run build                    # Production build
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
- **Docstrings**: Use Google style convention (configured in pyproject.toml)
- **Type hints**: Add type hints for function parameters and return values

### Django-Specific

- **Apps**: Define `AppConfig` classes in `apps.py` (e.g., `AccountsConfig`)
- **Models**:
  - Use `uuid` for unique identifiers when needed
  - Define `__str__` method for all models
  - Use `gettext_lazy` (`_`) for translatable strings
- **Model Managers**:
  - Extend `BaseUserManager` for custom user models
  - Implement `create_user()` and `create_superuser()` methods
  - Raise `ValueError` with descriptive messages for validation
  - Use `normalize_email()` for email fields
- **Settings**:
  - Use `django-environ` for environment variables
  - Settings split across `config/settings/` (base, local, test, production, staging)
  - Environment loader `engage.py` reads `WORK_ENV` from `.env`
- **URL patterns**: Always end paths with trailing comma
- **Admin**: Use `list_display`, `list_filter`, `search_fields` for usability
- **Testing**: Use Django's built-in test runner (no pytest configured)

### Tailwind/CSS

- **Config**: `theme/static_src/tailwind.config.js`
- **Entry**: `theme/static_src/src/styles.css`
- **Output**: `theme/static/css/dist/styles.css`
- **Plugins**: forms, typography, line-clamp, aspect-ratio (pre-configured)
- **Template paths**: Configured for `templates/**/*.html` patterns

### Templates

- **Formatter**: Use `djlint --reformat templates/`
- **Linter**: Use `djlint templates/ --check`
- **Profile**: Django (configured in pyproject.toml)
- **Indentation**: 2 spaces (configured in pyproject.toml)
- **Max line length**: 120 characters
- **CSS/JS formatting**: Disabled (format_css=false, format_js=false in pyproject.toml)
- **Template tags**: Load required tags (e.g., `{% load wagtailcore_tags %}`)
- **endblock naming**: Always specify block name in endblock tag (T003 rule)
  - Use `{% endblock content %}` instead of `{% endblock %}`
  - Use `{% endblock title %}` instead of `{% endblock %}`
- **Quotes**: Use double quotes in template tags (T002 rule)
  - Use `{% extends "base.html" %}` instead of `{% extends 'base.html' %}`
  - Use `{% include "partial.html" %}` instead of `{% include 'partial.html' %}`
- **Whitespace**: Avoid extra whitespace in template tags (T032 rule)
  - Use `{% if condition %}` not `{% if  condition %}`
  - Use `{{ variable }}` not `{{  variable  }}`
- **Attribute quotes**: Use double quotes for HTML attributes (H008 rule)
  - Use `class="container"` not `class='container'`
  - Use `href="https://example.com"` not `href='https://example.com'`
- **Ignored rules** (in pyproject.toml):
  - H021: Inline styles should be avoided
  - H030: Consider adding a meta description
  - H031: Consider adding meta keywords

### Error Handling

- Raise `ValueError` with descriptive messages in model managers
- Use Django's built-in validation where possible
- Log errors appropriately (Sentry SDK configured for production)

## Project Structure

```
config/                  # Django project settings
  settings/
    base.py             # Base settings (shared)
    engage.py           # Environment loader
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
pages/                  # Wagtail pages app
  models.py             # HomePage model
  tests.py              # Tests (currently empty)
theme/                  # Tailwind CSS app
  static_src/           # Tailwind source files
    src/styles.css      # CSS entry point
    tailwind.config.js  # Tailwind configuration
    package.json        # npm scripts
templates/              # HTML templates (root level)
  base.html            # Base template
  pages/               # Pages app templates
    home_page.html      # HomePage template
static/                 # Static files (dev)
staticfiles/            # Collected static files (production)
media/                  # User-uploaded files
pyproject.toml          # Project dependencies and config (uv-based)
manage.py               # Django management script
```

## Key Dependencies

- Django 5.2.x + django-environ
- Wagtail 7.2.x (CMS)
- django-tailwind 4.4.x (CSS integration)
- Tailwind CSS 3.0.x (CSS framework)
- psycopg2-binary 2.9.x (PostgreSQL)
- whitenoise 6.9.x (static files)
- sentry-sdk 2.22.x (error tracking)
- ruff 0.9.x (Python linting/formatting - replaces black and pylint)
- djlint 1.36.x (HTML template linting/formatting)

## Environment Setup

Required `.env` variables:
- `SECRET_KEY`
- `ALLOWED_HOSTS` (comma-separated)
- `DB_NAME`, `DB_USER`, `DB_PASSWORD`, `DB_HOST`

See `.env.example` for template.

## Notes

- Uses uv (not pip-tools, poetry or pipenv) for dependency management
- PostgreSQL required (SQLite config commented out in base.py)
- No pytest configured - use Django's built-in test runner
- No existing Cursor rules or Copilot instructions found in repo
