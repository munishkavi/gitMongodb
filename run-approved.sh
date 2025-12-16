#!/bin/bash

for script in approved/*.js; do
  echo "----------------------------------"
  echo "Processing $script"

  COUNT_QUERY=$(grep "^// COUNT:" "$script" | sed 's#// COUNT: ##')

  if [ -z "$COUNT_QUERY" ]; then
    echo "Missing COUNT in $script. Aborting."
    exit 1
  fi

  ACTUAL_COUNT=$(mongosh "$MONGO_URI" --quiet --eval "$COUNT_QUERY")
  echo "Auto-count result: $ACTUAL_COUNT"

  mongosh "$MONGO_URI" "$script"

  mv "$script" executed/
done
