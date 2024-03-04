#!/usr/bin/env bash
source .env
poetry run uvicorn main:app --host 0.0.0.0 --port ${BACKEND_PORT:-7001}
