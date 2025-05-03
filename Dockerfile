# ollama-service/Dockerfile

FROM ubuntu:22.04

# Install Curl & Unzip for the Ollama installer
RUN apt-get update && \
    apt-get install -y curl unzip && \
    rm -rf /var/lib/apt/lists/*

# Install the Ollama CLI
RUN curl -sL https://ollama.com/install.sh | bash

# Tell Ollama to bind to 0.0.0.0:11434
ENV OLLAMA_HOST=0.0.0.0:11434

# Copy in your fine‑tuned model under the extractor:latest tag
COPY --chown=ollama:ollama models/extractor:latest \
     /home/ollama/.ollama/models/extractor:latest

# Expose the Ollama port
EXPOSE 11434

# Launch Ollama serving your extractor:latest model
ENTRYPOINT ["ollama", "serve", "extractor:latest"]
