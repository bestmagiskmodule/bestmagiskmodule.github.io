#!/bin/bash

# Process all text files in the current directory
for input_file in *.md; do
  if [ -f "$input_file" ]; then
    temp_file="${input_file}.tmp"
    inside_yaml=false
    yaml_count=0

    echo "Processing $input_file..."

    # Start processing the file
    {
      while IFS= read -r line; do
        # Check if we are at a YAML delimiter (---)
        if [[ $line == "---" ]]; then
          yaml_count=$((yaml_count + 1))

          # Output the first two ---
          if [[ $yaml_count -le 2 ]]; then
            echo "$line"
            
            # Start the body tag after the second ---
            if [[ $yaml_count -eq 2 ]]; then
              echo "<body>"
            fi
          fi
          continue
        fi

        if [[ $yaml_count -lt 2 ]]; then
          # If still in YAML front matter, output the line as is
          echo "$line"
        else
          # Remove any additional ---
          if [[ $line == "---" ]]; then
            continue
          fi

          # Escape HTML special characters
          line=$(echo "$line" | sed 's/&/\&amp;/g; s/</\&lt;/g; s/>/\&gt;/g; s/"/\&quot;/g; s/'"'"'/\&#39;/g; s/`/\&#96;/g')

          # Handle markdown-style headers
          if [[ $line == \#* ]]; then
            header_level=$(echo "$line" | grep -o "^#*" | wc -c)
            header_level=$((header_level - 1))
            header_text=$(echo "$line" | sed 's/^#* //')
            echo "<h$header_level>$header_text</h$header_level>"

          # Handle bold text with **
          elif [[ $line == *\*\** ]]; then
            bold_text=$(echo "$line" | sed 's/\*\*\(.*\)\*\*/<strong>\1<\/strong>/g')
            echo "<p>$bold_text</p>"

          # Handle list items starting with * or -
          elif [[ $line == \* || $line == -* ]]; then
            list_item=$(echo "$line" | sed 's/^[*-] //')
            echo "<li>$list_item</li>"

          else
            # Wrap the line in a paragraph tag
            echo "<p>$line</p>"
          fi
        fi
      done < "$input_file"

      # Add the closing </body> tag
      echo "</body>"

    } > "$temp_file"

    # Replace the original file with the processed file
    mv "$temp_file" "$input_file"
    echo "$input_file has been updated."

  fi
done

echo "All files processed."
