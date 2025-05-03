FROM ubuntu:22.04

# Install Curl & Unzip for the Ollama installer
RUN apt-get update && \
    apt-get install -y curl unzip && \
    rm -rf /var/lib/apt/lists/*

# Install Ollama
RUN curl -fsSL https://ollama.com/install.sh | bash

# Set host binding
ENV OLLAMA_HOST=0.0.0.0:11434

# Copy your model into Ollama's model storage
COPY models/extractor:latest /root/.ollama/models/extractor:latest

# Expose the Ollama API port
EXPOSE 11434

# Start the Ollama server (don't pass model name here)
ENTRYPOINT ["ollama", "serve"]
