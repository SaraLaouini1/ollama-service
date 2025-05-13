FROM ubuntu:22.04

# Install Curl & Unzip for the Ollama installer
RUN apt-get update && \
    apt-get install -y curl unzip && \
    rm -rf /var/lib/apt/lists/*

# Install Ollama
RUN curl -fsSL https://ollama.com/install.sh | bash

# Preload your fine-tuned model so it's available at startup
RUN ollama pull extractor:latest || echo "Model extractor:latest already present"

# Set host binding
ENV OLLAMA_HOST=0.0.0.0:11434

# Copy your model into Ollama's model storage using JSON array form to handle the colon in the path
COPY ["models/extractor:latest", "/root/.ollama/models/extractor:latest"]

# Expose the Ollama API port
EXPOSE 11434

# (Optional) Add a healthcheck to verify the /generate endpoint is up
HEALTHCHECK --interval=30s --timeout=5s CMD curl -f http://localhost:11434/generate || exit 1

# Start the Ollama server (native /generate endpoint only)
ENTRYPOINT ["ollama", "serve"]
