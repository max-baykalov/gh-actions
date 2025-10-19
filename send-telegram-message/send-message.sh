#!/bin/bash
set -e

BOT_TOKEN="$1"
CHAT_ID="$2"
MESSAGE="$3"

# Send Telegram message
RESPONSE=$(curl -s -X POST "https://api.telegram.org/bot${BOT_TOKEN}/sendMessage" \
  -H "Content-Type: application/json" \
  -d "{
    \"chat_id\": \"${CHAT_ID}\",
    \"text\": \"${MESSAGE}\"
  }")

# Check for errors
OK=$(echo "$RESPONSE" | jq -r '.ok')
if [ "$OK" != "true" ]; then
  echo "::error::Telegram API call failed: $RESPONSE"
  exit 1
fi

echo "✅ Telegram message sent"
