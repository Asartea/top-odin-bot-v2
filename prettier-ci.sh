#!/bin/sh

# This script will run prettier on all files that have been changed when compared to main

# Get the list of changed files
changed_files=$(git diff --name-status main)

# Loop through the list of changed files
echo "$changed_files" | while read -r file; do
  # Get the mode and file path
  mode=$(echo "$file" | cut -f1)
  filePath=$(echo "$file" | cut -f2)
  # Check if the file is modified or added
  if [ "$mode" = "M" ] || [ "$mode" = "A" ] || [ "$mode" = "AM" ]; then
    # Run prettier on the file
    npx prettier --write "$filePath"
  fi
done
