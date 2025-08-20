# Use Python 3.12 slim image
FROM python:3.12-slim

# Install uv
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /usr/local/bin/

# Set working directory
WORKDIR /app

# Copy dependency files first
COPY pyproject.toml uv.lock ./

# Install dependencies only (no local package)
RUN uv sync --frozen --no-dev --no-install-project

# Copy application code
COPY . .

# Expose port 8000
EXPOSE 8000

# Run the application directly with the virtual environment
CMD [".venv/bin/python", "weather.py", "--port", "8000"]