#!/bin/bash

# Function to remove AdSense code from a file
remove_adsense_code() {
    local file="$1"

    # Use Perl to remove the specified AdSense code
    perl -0777 -i -pe 's/<script async src="https:\/\/pagead2\.googlesyndication\.com\/pagead\/js\/adsbygoogle\.js\?client=ca-pub-8370893026371321" crossorigin="anonymous"><\/script>\s*<!-- Display 2 -->\s*<ins class="adsbygoogle" style="display:block" data-ad-client="ca-pub-8370893026371321" data-ad-slot="4101050007" data-ad-format="auto" data-full-width-responsive="true"><\/ins>\s*<script>\s*\(adsbygoogle = window.adsbygoogle \|\| \[\]\)\.push\(\{\}\);\s*<\/script>//sg' "$file"

    echo "Removed AdSense code from $file"
}

# Main script logic
# Find all HTML files in the current directory and subdirectories
find . -type f -name "*.md" | while read -r file; do
    remove_adsense_code "$file"
done

echo "AdSense code removal completed for all HTML files in the current directory."
