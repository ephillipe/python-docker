#!/bin/bash
set -e

APP_SCRIPT=${APP_SCRIPT:-application.py}
APP_REQUIREMENTS=${APP_REQUIREMENTS:-requirements.txt}
APP_PORT=${APP_PORT:-8080}
CURRENT_DIR=$(pwd)

echo "Current directory: " $CURRENT_DIR
echo "Application script: " $APP_SCRIPT
echo "Application requirements: " $APP_REQUIREMENTS
echo "Application port: " $APP_PORT
export PYTHONPATH="${PYTHONPATH}":$CURRENT_DIR
echo "Current PYTHONPATH:" $PYTHONPATH

echo "Preparing Python environment..."
pip install --upgrade -r $APP_REQUIREMENTS

echo "Starting cron..."
service cron start

echo "Starting application..."
exec "$@"
