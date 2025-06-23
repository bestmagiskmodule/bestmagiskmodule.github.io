#!/bin/bash

# Function to append lines after the last occurrence of a pattern in .md and .html files
append_lines_after_last_occurrence() {
    local pattern="$1"
    local lines_to_append="$2"

    # Find all .md and .html files and append lines after the last occurrence of the pattern
    find . -type f \( -name '*.md' -o -name '*.html' \) -exec bash -c '
        for file; do
            # Find the line number of the last occurrence of the pattern
            last_occurrence=$(grep -n "$1" "$file" | cut -d: -f1 | tail -n1)
 
            # Append lines after the last occurrence
            if [ -n "$last_occurrence" ]; then
                sed -i "${last_occurrence}a\\
$2
" "$file"
            fi
        done' bash "$pattern" "$lines_to_append" {} +
}

# Function to add lines on the next line of the specified line number
add_lines_on_next_line() {
    local line_number="$1"
    local lines_to_add="$2"

    # Find all .md and .html files and add lines on the next line of the specified line number
    find . -type f \( -name '*.md' -o -name '*.html' \) -exec bash -c '
        for file; do
            if [ -n "$1" ]; then
                sed -i "${1}a\\
$2
" "$file"
            fi
        done' bash "$line_number" "$lines_to_add" {} +
}

# Function to find and replace text
find_and_replace() {
    local find_text="$1"
    local replace_text="$2"

    # Find all .md and .html files and replace text
    find . -type f \( -name '*.md' -o -name '*.html' \) -exec sed -i "s/$find_text/$replace_text/g" {} +
}

# Function to backup current directory
backup_directory() {
    local backup_dir=".bk_$(date +%Y-%m-%d_%H-%M-%S)"

    # Create backup directory
    mkdir "$backup_dir"

    # Copy all files and directories except backups to the backup directory
    cp -r . "$backup_dir"

    echo "Backup created: $backup_dir"
}

# Main script
echo "Options:"
echo "  1. Add text next line Lines"
echo "  2. Add Line on Next Line"
echo "  3. Find and Replace"
echo "  4. Backup"

# Read user choice
echo -n "Enter your choice: "
read choice

case $choice in
    1)
        # Append Lines option
        echo -n "Enter keyword to search for: "
        read pattern
        echo -n "Enter lines to append (separate each line with \\n, use \\\\t for indentation): "
        read lines_to_append

        append_lines_after_last_occurrence "$pattern" "$lines_to_append"
        echo "Lines appended after the last occurrence of '$pattern' successfully."
        ;;

    2)
        # Add Lines on Next Line of Specified Line Number option
        echo -n "Enter the line number: "
        read line_number
        echo -n "Enter lines to add (separate each line with \\n, use \\\\t for indentation): "
        read lines_to_add

        add_lines_on_next_line "$line_number" "$lines_to_add"
        echo "Lines added on the next line of line number $line_number successfully."
        ;;

    3)
        # Find and Replace option
        echo -n "Enter the text to find: "
        read find_text
        echo -n "Enter the replacement text: "
        read replace_text

        find_and_replace "$find_text" "$replace_text"
        echo "Text replaced successfully."
        ;;

    4)
        # Backup option
        backup_directory
        ;;

    *)
        echo "Invalid option."
        ;;
esac
