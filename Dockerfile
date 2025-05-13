FROM ubuntu:22.04

# 1) Install Ollama
RUN apt-get update && \
    apt-get install -y curl unzip && \
    rm -rf /var/lib/apt/lists/* && \
    curl -fsSL https://ollama.com/install.sh | bash

# 2) Copy your fine-tuned model artifacts
#    Make sure your host dir is exactly 'models/extractor:latest'
COPY ["models/extractor:latest", "/root/.ollama/models/extractor:latest"]

# 3) Bind to all interfaces
ENV OLLAMA_HOST=0.0.0.0:11434

# 4) Expose and healthcheck
EXPOSE 11434
HEALTHCHECK --interval=30s --timeout=5s \
  CMD curl -sf http://localhost:11434/generate || exit 1

# 5) Start the server
ENTRYPOINT ["ollama", "serve"]
