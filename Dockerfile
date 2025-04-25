# ollama-service/Dockerfile
FROM ubuntu:22.04

# Install Ollama dependencies & CLI
RUN apt-get update && apt-get install -y curl unzip \
 && curl -sL https://ollama.com/install.sh | bash

# Expose the LLM port
EXPOSE 11434

# On container start:
#  1. Pull the model (daemon is launched automatically by ollama CLI if needed)
#  2. Serve on 0.0.0.0:11434
CMD ["bash","-lc","ollama pull mistral:latest && ollama serve --host 0.0.0.0 --port 11434"]
