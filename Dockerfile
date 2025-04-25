# ollama-service/Dockerfile
FROM ubuntu:22.04

# Install Ollama dependencies & CLI
RUN apt-get update \
 && apt-get install -y curl unzip \
 && curl -sL https://ollama.com/install.sh | bash

EXPOSE 11434

# Start the daemon first, wait for it, then pull your model, then keep it running
CMD ["bash","-lc", "\
  ollama serve --host 0.0.0.0 --port 11434 & \
  # wait until Ollama API is up: \
  until curl -s http://127.0.0.1:11434; do sleep 1; done; \
  ollama pull mistral:latest; \
  # now wait on the background serve process so container doesn’t exit \
  wait \
"]
