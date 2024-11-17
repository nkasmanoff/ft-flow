#!/bin/bash

# Check if correct number of arguments are provided
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <gguf-path> <system-prompt> <ollama-model-name>"
    exit 1
fi

GGUF_PATH="$1"
SYSTEM_PROMPT="$2"
MODEL_NAME="$3"

# Create Modelfile
cat > Modelfile << EOL
FROM $GGUF_PATH
TEMPLATE "{{ if .System }}<|im_start|>system
{{ .System }}<|im_end|>{{ end }}
<|im_start|>user
{{ .Prompt }}<|im_end|>
<|im_start|>assistant
"
PARAMETER stop <|im_start|>
PARAMETER stop <|im_end|>
PARAMETER temperature 0
SYSTEM "$SYSTEM_PROMPT"
EOL

# Create and test the model
echo "Creating Ollama model..."
ollama create "$MODEL_NAME" -f Modelfile

# Prompt user for username
read -p "Enter your Ollama username: " OLLAMA_USERNAME

# Copy and push to repository
echo "Copying model to repository format..."
ollama cp "$MODEL_NAME" "$OLLAMA_USERNAME/$MODEL_NAME"

echo "Pushing model to Ollama repository..."
ollama push "$OLLAMA_USERNAME/$MODEL_NAME"

echo "Testing final pushed model..."
ollama run "$OLLAMA_USERNAME/$MODEL_NAME" --verbose