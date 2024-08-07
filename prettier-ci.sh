#!/bin/sh

# This script will run prettier on all JavaScript, JSON, YAML, and YML files that have been changed when compared to main

# Get the list of changed files
changed_files=$(git diff --name-status main)

# Iterate over the list of changed files
echo "$changed_files" | while IFS=$'\t' read -r file; do
    # Get the mode and file path
    mode=$(echo "$file" | cut -f1)
    filePath=$(echo "$file" | cut -f2)
    # Check if the file is modified or added
    if [ "$mode" = "M" ] || [ "$mode" = "A" ] || [ "$mode" = "AM" ]; then
        # Check if the file extension is .js, .json, .yml, or .yaml
        case "$filePath" in
            *.js|*.json|*.yml|*.yaml)
                npx prettier --write "$filePath"
                ;;
        esac
    fi
done
