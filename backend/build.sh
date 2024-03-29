#!/usr/bin/env bash
# exit on error
set -o errexit

#!/bin/bash
# Get the Python version
version=$(python3 -c 'import sys; print(".".join(map(str, sys.version_info[:3])))')

# Check if the Python version is greater than or equal to 3.8
if [ "$(printf '%s\n' "$version" "3.8" | sort -V | head -n1)" = "3.8" ]; then
    echo "Python version is good !! >= 3.8"
else
    echo "Python version is less than 3.8"
fi

# Set the location of the poetry home directory
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


# Build the Docker image
sudo docker build -t screenshot-backend .

# Run a Docker container in the background and retrieve its ID
container_id=$(sudo docker run -d -p 7001:80 screenshot-backend)

# Display the logs of the container
sudo docker logs $container_id
