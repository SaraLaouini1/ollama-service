# ollama-service/Dockerfile
FROM ubuntu:22.04

# Install Ollama dependencies & CLI
RUN apt-get update \
 && apt-get install -y curl unzip \
 && curl -sL https://ollama.com/install.sh | bash

# Tell Ollama to bind on all interfaces at port 11434
ENV OLLAMA_HOST=0.0.0.0:11434
# Expose the same port
EXPOSE 11434

# Start the Ollama daemon, wait until it’s ready, then pull the model
CMD ["bash","-lc", "\
  ollama serve & \
  # wait for Ollama to be up:
  until curl -s http://127.0.0.1:11434; do sleep 1; done; \
  ollama pull llama3.2:1b; \
  # block on the serve process so the container stays alive
  wait \
"]
