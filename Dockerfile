FROM python:3.11-slim

ENV DEBIAN_FRONTEND=noninteractive

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    wget \
    curl \
    git \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements.txt to container
COPY requirements.txt /tmp/requirements.txt

# Install Python dependencies
RUN pip install --no-cache-dir -r /tmp/requirements.txt

# Set the working directory
WORKDIR /home/jovyan/work

# Expose port for Jupyter
EXPOSE 8888

# Launch Jupyter Lab
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--allow-root", "--NotebookApp.token=''", "--NotebookApp.password=''", "--NotebookApp.notebook_dir=/home/jovyan/work", "--NotebookApp.allow_origin='*'", "--NotebookApp.disable_check_xsrf=True"]
