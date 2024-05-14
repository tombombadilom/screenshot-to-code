#!/usr/bin/env bash
export POETRY_HOME=/opt/poetry

# Create a new virtual environment using Python3 at the poetry home directory
sudo python3 -m venv $POETRY_HOME

# Upgrade pip in the virtual environment
sudo $POETRY_HOME/bin/pip install --upgrade pip
# Install the latest version of poetry
echo "Installing the latest version of poetry..."
sudo $POETRY_HOME/bin/pip install poetry==1.7
sudo $POETRY_HOME/bin/pip install --upgrade poetry

# Check the installed version of poetry
sudo $POETRY_HOME/bin/poetry --version

# Remove the existing poetry lock file if it exists
echo "Removing the existing poetry lock file..."
sudo rm poetry.lock

# Generate a new lock file
$POETRY_HOME/bin/poetry lock

# Install the dependencies specified in the pyproject.toml file
sudo $POETRY_HOME/bin/poetry install --no-root

poetry install
poetry shell
poetry run uvicorn main:app --host 0.0.0.0 --port ${BACKEND_PORT:-7001}
