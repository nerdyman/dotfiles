#!/bin/bash

#cat ./extensions.json | jq -r '.[].identifier.id' | xargs -L 1 cursor --install-extension

cat extensions.json | jq -r '.[].identifier.id' | while read ext; do
  cursor --no-sandbox --force --install-extension "$ext"
done

