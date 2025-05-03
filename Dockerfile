# ollama-service/Dockerfile

# 1. Start from a minimal Linux
FROM ubuntu:22.04

# 2. Install curl & unzip (needed by the Ollama installer)
RUN apt-get update && \
    apt-get install -y curl unzip && \
    rm -rf /var/lib/apt/lists/*

# 3. Install the official Ollama CLI
RUN curl -sL https://ollama.com/install.sh | bash

# 4. Copy in your fine‑tuned model
COPY --chown=ollama:ollama models/extractor:latest \
     /home/ollama/.ollama/models/extractor:latest

# 5. Expose the API port
EXPOSE 11434

# 6. Make Ollama the entrypoint, and default to serving your model
ENTRYPOINT ["ollama"]
CMD ["serve", "extractor:latest", "--host", "0.0.0.0"]
