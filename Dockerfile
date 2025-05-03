FROM ollama/ollama:latest

# Copy your fine‑tuned model files into Ollama's models directory
COPY --chown=ollama:ollama models/extractor:latest \
     /home/ollama/.ollama/models/extractor:latest

EXPOSE 11434

# Serve the extractor:latest tag (no pull or convert needed)
CMD ["ollama", "serve", "extractor:latest", "--host", "0.0.0.0"]
