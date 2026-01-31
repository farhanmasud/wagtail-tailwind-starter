# Wagtail + Tailwind CSS Starter

[![Python](https://img.shields.io/badge/python-3.10+-blue.svg)](https://www.python.org/)
[![Django](https://img.shields.io/badge/django-5.2-green.svg)](https://www.djangoproject.com/)
[![Wagtail](https://img.shields.io/badge/wagtail-7.2-43b0b3.svg)](https://wagtail.org/)
[![Tailwind CSS](https://img.shields.io/badge/tailwind-4.x-38B2AC.svg)](https://tailwindcss.com/)
[![Code style: Ruff](https://img.shields.io/badge/code%20style-ruff-000000.svg)](https://github.com/astral-sh/ruff)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

A modern, production-ready starter template for building content-managed websites with Django 5.2, Wagtail 7.2 CMS, and Tailwind CSS 4.x.

Designed for developers who want a quick, opinionated setup with best practices built-in.

## ✨ Features

- **Modern Stack**: Django 5.2 (LTS), Wagtail 7.2, Tailwind CSS 4.x
- **Custom User Model**: Email-based authentication out of the box
- **Package Management**: Uses `uv` for blazing-fast dependency management
- **Code Quality**: Ruff for linting and formatting (replaces black/flake8)
- **Environment Config**: django-environ for 12-factor app compliance
- **Multi-environment**: Local, testing, staging, production settings
- **Production Ready**: Whitenoise, Sentry integration, security headers
- **Developer Experience**: Debug toolbar, browser reload, django-extensions

## 📋 Requirements

- Python 3.10+
- PostgreSQL
- Node.js 20+ (for Tailwind CSS)

## 🚀 Quick Start

```bash
# 1. Clone the repository
git clone https://github.com/farhanmasud/wagtail-tailwind-starter.git myproject
cd myproject

# 2. Setup environment
cp .env.example .env
# Edit .env with your settings (database, secret key, etc.)

# 3. Make scripts executable
chmod +x *.sh

# 4. Setup database (requires PostgreSQL running)
bash setup-db.sh

# 5. Install dependencies
# Option A: With flags (non-interactive)
bash setup-uv.sh -d  # Development environment
# bash setup-uv.sh -p  # Production environment

# Option B: Interactive mode
# bash setup-uv.sh
# Then choose 'd' or 'p' when prompted

# 6. Activate virtual environment
source venv/bin/activate

# 7. Install Tailwind CSS dependencies
python manage.py tailwind install

# 8. Run migrations
python manage.py migrate

# 9. Collect static files
python manage.py collectstatic --no-input

# 10. Start development (run in two separate terminals)
python manage.py runserver          # Terminal 1
python manage.py tailwind start     # Terminal 2
```

Visit http://localhost:8000 to see your site and http://localhost:8000/cms/ for the Wagtail admin.

## 📁 Project Structure

```
myproject/
├── accounts/               # Custom user app (email-based auth)
│   ├── models.py          # Account model
│   ├── admin.py           # AccountAdmin configuration
│   ├── forms.py           # Account forms
│   └── tests.py           # Tests
├── config/                # Django project configuration
│   ├── settings/          # Environment-specific settings
│   │   ├── base.py       # Base settings (shared)
│   │   ├── local.py      # Development settings
│   │   ├── production.py # Production settings
│   │   ├── staging.py    # Staging settings
│   │   ├── test.py       # Test settings
│   │   └── engage.py     # Environment loader
│   ├── urls.py           # URL configuration
│   └── wsgi.py           # WSGI entry point
├── theme/                 # Tailwind CSS app
│   └── static_src/       # Tailwind source files
├── static/               # Static files (development)
├── staticfiles/          # Collected static files
├── templates/            # HTML templates
├── media/                # User-uploaded files
├── pyproject.toml        # Dependencies (uv-based)
├── manage.py             # Django management script
├── setup-uv.sh           # uv setup script
├── setup-db.sh           # Database setup script
├── update-git-remote.sh  # Git remote update script
└── .env.example          # Environment variables template
```

## 👤 Custom User Model

This starter includes a custom user model (`accounts.Account`) that uses **email as the unique identifier** instead of username:

- Email is required and unique
- No username field
- Fully integrated with Django admin
- Compatible with Wagtail's user management

To create a superuser:

```bash
python manage.py createsuperuser
# Enter email and password when prompted
```

## 🛠 Development Workflow

### Code Quality

```bash
# Run linter (ruff)
ruff check .

# Fix auto-fixable issues
ruff check --fix .

# Format code
ruff format .
```

### Database

```bash
# Create migrations
python manage.py makemigrations

# Run migrations
python manage.py migrate

# Collect static files for production
python manage.py collectstatic --no-input
```

### Testing

```bash
# Run all tests
python manage.py test

# Run tests for specific app
python manage.py test accounts

# Run specific test class or method
python manage.py test accounts.tests.AccountModelTest
python manage.py test accounts.tests.AccountModelTest.test_method
```

## ⚙️ Configuration

Create a `.env` file based on `.env.example`. Key variables:

| Variable | Description | Default |
|----------|-------------|---------|
| `WORK_ENV` | Environment: local, testing, staging, production | local |
| `SECRET_KEY` | Django secret key (generate new for production) | - |
| `ALLOWED_HOSTS` | Comma-separated list of allowed hosts | localhost,127.0.0.1 |
| `DB_NAME` | PostgreSQL database name | - |
| `DB_USER` | PostgreSQL user | - |
| `DB_PASSWORD` | PostgreSQL password | - |
| `DB_HOST` | PostgreSQL host | localhost |
| `DB_PORT` | PostgreSQL port | 5432 |
| `WAGTAIL_SITE_NAME` | Site name in Wagtail admin | My Example Site |
| `WAGTAILADMIN_BASE_URL` | Base URL for admin | http://localhost:8000 |
| `SENTRY_DSN` | Sentry DSN for error tracking (optional) | - |

See `.env.example` for the complete list.

## 🚀 Deployment

### Production Checklist

1. Set `WORK_ENV=production` in environment
2. Generate a new `SECRET_KEY` for production
3. Configure `ALLOWED_HOSTS` with your domain(s)
4. Set up PostgreSQL database
5. Configure `SENTRY_DSN` for error monitoring (optional)
6. Set `SECURE_SSL_REDIRECT=true` for HTTPS
7. Run `python manage.py collectstatic --no-input`
8. Run `python manage.py migrate`

### Environment Variables for Production

```bash
WORK_ENV=production
SECRET_KEY=your-generated-secret-key
ALLOWED_HOSTS=yourdomain.com,www.yourdomain.com
CSRF_TRUSTED_ORIGINS=https://yourdomain.com,https://www.yourdomain.com
DEBUG=false
SECURE_SSL_REDIRECT=true
SECURE_HSTS_SECONDS=31536000
```

## 🆘 Troubleshooting

### Database Connection Issues

**Problem**: `psycopg2.OperationalError: connection to server failed`

**Solution**:
1. Ensure PostgreSQL is running: `sudo systemctl status postgresql`
2. Check credentials in `.env` file
3. Verify database exists: `sudo -u postgres psql -l`
4. If port is different from 5432, update `DB_PORT` in `.env`

### Tailwind CSS Not Loading

**Problem**: Styles not updating or 404 errors for CSS

**Solution**:
1. Ensure you've run: `python manage.py tailwind install`
2. Make sure `python manage.py tailwind start` is running in a separate terminal
3. Check that `TAILWIND_APP_NAME = "theme"` is in settings
4. Clear browser cache and restart the dev server

### Permission Denied on Scripts

**Problem**: `bash: setup-uv.sh: Permission denied`

**Solution**:
```bash
chmod +x *.sh
```

### uv Installation Issues

**Problem**: `command not found: uv`

**Solution**:
1. The script will auto-install uv, but you may need to reload your shell:
   ```bash
   source ~/.cargo/bin/env
   ```
2. Or manually install: `curl -LsSf https://astral.sh/uv/install.sh | sh`

### Static Files 404 in Production

**Problem**: Static files not serving in production

**Solution**:
1. Ensure `python manage.py collectstatic --no-input` was run
2. Check that `STATIC_ROOT` is set correctly in settings
3. Verify Whitenoise middleware is in `MIDDLEWARE`

### Sentry Not Logging Errors

**Problem**: Errors not appearing in Sentry

**Solution**:
1. Check `SENTRY_DSN` is set correctly in `.env`
2. Ensure DSN format is correct (no quotes, full URL)
3. For local testing, Sentry is wrapped in `suppress()` and won't raise errors

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- [Django](https://www.djangoproject.com/) - The web framework for perfectionists
- [Wagtail](https://wagtail.org/) - The friendly CMS
- [Tailwind CSS](https://tailwindcss.com/) - Utility-first CSS framework
- [django-tailwind](https://github.com/timonweb/django-tailwind) - Tailwind integration
- [uv](https://github.com/astral-sh/uv) - Fast Python package installer
- [Ruff](https://github.com/astral-sh/ruff) - Fast Python linter and formatter
