#!/bin/bash

# Set OpenAI API Key
API_KEY=${OPENAI_API_KEY}
ENDPOINT="https://api.openai.com/v1/chat/completions"

# Defaults
MODEL="gpt-4o-mini"
TEMPERATURE="0.5"

# Parse arguments
SYSTEM_PROMPT=""
HUMAN_PROMPT=""
STDIN_INPUT=""

# Check for stdin input
if ! [ -t 0 ]; then
    STDIN_INPUT=$(cat)
fi

for arg in "$@"; do
    case $arg in
        --model=*)
            MODEL="${arg#*=}"
            shift
            ;;
        --temperature=*)
            TEMPERATURE="${arg#*=}"
            shift
            ;;
        *)
            if [[ -z "$SYSTEM_PROMPT" ]]; then
                SYSTEM_PROMPT="$arg"
            elif [[ -z "$HUMAN_PROMPT" ]]; then
                HUMAN_PROMPT="$arg"
            fi
            shift
            ;;
    esac
done

# Show usage if neither STDIN input nor HUMAN_PROMPT is provided
if [[ -z "$STDIN_INPUT" && -z "$HUMAN_PROMPT" ]]; then
    echo "Usage: $0 <system prompt or system-prompt-file-path.prompt> <human-message prompt or human-message-prompt-file-path.prompt> [--model=model_name] [--temperature=temperature_value]"
    echo "Example with file input: cat README.md | $0 \"You are a summary assistant\" \"Explain in one sentence the idea\""
    exit 1
fi

# Read prompts from files if paths are provided
if [[ -f "$SYSTEM_PROMPT" ]]; then
    SYSTEM_PROMPT=$(cat "$SYSTEM_PROMPT")
fi

if [[ -f "$HUMAN_PROMPT" ]]; then
    HUMAN_PROMPT=$(cat "$HUMAN_PROMPT")
fi

# Escape STDIN to make it safe
if [[ -n "$STDIN_INPUT" ]]; then
    STDIN_INPUT=$(printf '%s' "$STDIN_INPUT" | jq -Rsa . | sed -e 's/^"//' -e 's/"$//')
    HUMAN_PROMPT="Here is the context:\n$STDIN_INPUT\n\n$HUMAN_PROMPT"
fi


# Append instruction to system prompt
SYSTEM_PROMPT="$SYSTEM_PROMPT Do not add additional explanation or description, just answer the user query."

# Validate inputs
if [[ -z "$SYSTEM_PROMPT" || -z "$HUMAN_PROMPT" ]]; then
    echo "Usage: $0 <system prompt or system-prompt-file-path.prompt> <human-message prompt or human-message-prompt-file-path.prompt> [--model=model_name] [--temperature=temperature_value]"
    exit 1
fi

# Make API request
response=$(curl -s -X POST "$ENDPOINT" \
    -H "Authorization: Bearer $API_KEY" \
    -H "Content-Type: application/json" \
    -d "{
          \"model\": \"$MODEL\",
          \"messages\": [
              {\"role\": \"system\", \"content\": \"$SYSTEM_PROMPT\"},
              {\"role\": \"user\", \"content\": \"$HUMAN_PROMPT\"}
          ],
          \"temperature\": $TEMPERATURE
        }")
# Check for errors in the response
if echo "$response" | jq -e '.error' > /dev/null 2>&1; then
    error_message=$(echo "$response" | jq -r '.error.message')
    echo "Error: $error_message"
    exit 1
fi

# Extract and print only the text response
echo "$response" | jq -r '.choices[0].message.content' | sed '/^$/d'
