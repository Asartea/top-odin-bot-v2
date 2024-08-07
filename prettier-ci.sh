#!/bin/sh

# This script will run prettier on all JavaScript, JSON, YAML, and YML files that have been changed when compared to main

# Get the list of changed files
changed_files=$(git diff --name-status main)

# Create an empty array to store the file paths
files_to_format=()

# Iterate over the list of changed files
while read -r file; do
    mode=$(echo "$file" | cut -f1)
    filePath=$(echo "$file" | cut -f2)
    if [ "$mode" = "M" ] || [ "$mode" = "A" ] || [ "$mode" = "AM" ]; then
        case "$filePath" in
            *.js|*.json|*.yml|*.yaml)
                files_to_format+=("$filePath")
                ;;
        esac
    fi
    # Check if the file extension is .js, .json, .yml, or .yaml
done <<< "$changed_files"

echo "Files to format: ${files_to_format[@]}"
# Run prettier on each file in the array
npx prettier --check "${files_to_format[@]}"
