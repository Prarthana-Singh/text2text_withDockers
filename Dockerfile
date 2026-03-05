# Use official Python image
FROM python:3.9

# Set working directory
WORKDIR /code

# Copy requirements first (better Docker caching)
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir --upgrade -r requirements.txt

# Create non-root user
RUN useradd -m user

# Switch to user
USER user

# Environment variables
ENV HOME=/home/user \
    PATH=/home/user/.local/bin:$PATH

# App directory
WORKDIR $HOME/app

# Copy project files
COPY --chown=user . .

# Start server
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "7860"]