#!/bin/sh

# This script will run prettier on all JavaScript, JSON, YAML, and YML files that have been changed when compared to main

# Get the list of changed files
changed_files=$(git diff --name-status main)

# Loop through the list of changed files
echo "$changed_files" | while read -r file; do
    # Get the mode and file path
    mode=$(echo "$file" | cut -f1)
    filePath=$(echo "$file" | cut -f2)
    # Check if the file is modified or added
    if [ "$mode" = "M" ] || [ "$mode" = "A" ] || [ "$mode" = "AM" ]; then
        # Check if the file extension is .js, .json, .yml, or .yaml
        if [[ "$filePath" == *.js || "$filePath" == *.json || "$filePath" == *.yml || "$filePath" == *.yaml ]]; then
            # Run prettier on the file
            npx prettier --write "$filePath"
        fi
    fi
done
done
