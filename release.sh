#!/usr/bin/env bash

NAME="jodie"
GITHUB_USER="hernamesbarbara"

# Corrected variable expansion in URL
URL="https://github.com/${GITHUB_USER}/${NAME}/archive/refs/heads/main.zip"

# Define the temporary file name
TEMP_ZIP="${NAME}-main-temp.zip"

# Download the file
echo "Downloading $URL..."
curl -L -o "$TEMP_ZIP" "$URL"

# Calculate the SHA-256 checksum
echo "Calculating SHA-256 checksum..."
SHASUM=$(shasum -a 256 "$TEMP_ZIP" | awk '{print $1}')

# Output the checksum
echo "SHA-256 checksum: $SHASUM"

# Clean up: remove the downloaded zip file
rm "$TEMP_ZIP"
