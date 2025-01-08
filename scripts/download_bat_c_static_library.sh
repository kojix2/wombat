#!/bin/bash

# Set the destination directory
DEST_DIR="$(dirname "$0")/../src/ext"
mkdir -p "$DEST_DIR"

# Set the download URL
URL="https://github.com/kojix2/bat-c/releases/latest/download"

# Determine OS and set the file names to download
if [[ "$OSTYPE" == "darwin"* ]]; then
  ZIP_FILE="bat_c_macos.zip"
  TARGET_FILE="libbat_c.a"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
  ZIP_FILE="bat_c_ubuntu.zip"
  TARGET_FILE="libbat_c.a"
else
  echo "Unsupported OS"
  exit 1
fi

# Download the file
echo "Downloading $ZIP_FILE from $URL..."
curl -LO "${URL}/${ZIP_FILE}"

# Extract the ZIP file and copy the target file to the destination directory
echo "Extracting $TARGET_FILE..."
unzip -o "$ZIP_FILE" "$TARGET_FILE" -d "$DEST_DIR"

# Remove the downloaded ZIP file
echo "Cleaning up..."
rm "$ZIP_FILE"

echo "Done! $TARGET_FILE has been saved in $DEST_DIR."
