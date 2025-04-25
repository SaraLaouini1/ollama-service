# Use a minimal base
FROM ubuntu:22.04

# Install dependencies & Ollama
RUN apt-get update && \
    apt-get install -y curl unzip && \
    curl -sL https://ollama.com/install.sh | bash

# Pull the model you’ll use
RUN ollama pull mistral:latest

# Expose Ollama’s default port
EXPOSE 11434

# Start Ollama
CMD ["ollama", "serve", "--host", "0.0.0.0", "--port", "11434"]
