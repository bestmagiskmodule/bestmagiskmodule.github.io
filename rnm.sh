#!/bin/bash

# Define the old and new HTML content
old_content='https://magiskzip.gitlab.io'
new_content='https://magiskmodules.gitlab.io'

# Find all HTML files in the current directory and subdirectories
find . -type f -name "*.html" | while read -r file; do
  # Escape special characters for sed compatibility
  escaped_old=$(printf '%s\n' "$old_content" | sed 's/[&/\]/\\&/g')
  escaped_new=$(printf '%s\n' "$new_content" | sed 's/[&/\]/\\&/g')
  
  # Use sed to replace old content with new content
  sed -i "s|$escaped_old|$escaped_new|" "$file"
  echo "Updated content in: $file"
done

echo "Replacement completed."
