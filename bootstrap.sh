#!/bin/bash

echo "🔧 Setting up your Django micro-SaaS project..."

# Check Python
if ! command -v python3 &> /dev/null; then
  echo "❌ Python3 not found. Please install Python 3.10+"
  exit 1
fi

# Create virtualenv
python3 -m venv venv
source venv/bin/activate

# Upgrade pip
pip install --upgrade pip

# Install Python dependencies
pip install -r requirements.txt

# Install Node dependencies (for Tailwind)
if [ -f package.json ]; then
  echo "📦 Installing Node packages..."
  npm install
fi

# Setup .env from example
if [ ! -f .env ]; then
  echo "⚙️  Creating .env from .env.example"
  cp .env.example .env
fi

# Run initial migrations
python manage.py migrate

# Create superuser (interactive)
echo "👤 Creating superuser..."
python manage.py createsuperuser

# Collect static files
python manage.py collectstatic --noinput

echo "✅ Done! Run the server with:"
echo "source venv/bin/activate && python manage.py runserver"

