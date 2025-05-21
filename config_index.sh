#!/bin/bash

# --- Configuration ---
INDEX_HTML_PATH="/home/rojank/hw_utilization_tpu/index.html"
CONTENT_BASE_DIR="/home/rojank/hw_utilization_tpu/webpage_content/z1"

# This is the base URL path for your content on GitHub Pages.
# It should be the part of the URL *after* your domain and *before* the specific content directory.
# Based on your example URL:
# https://rojank-google.github.io/hw_utilization_tpu/webpage_content/z1/2025.2_to_2025.5/main.html
# The base path that corresponds to CONTENT_BASE_DIR is:
WEB_ROOT_FOR_CONTENT="/hw_utilization_tpu/webpage_content/z1/" # <--- CONFIRMED FOR YOUR EXAMPLE

LINK_SECTION_START='<div class="link-section">'
LINK_SECTION_END='</div>'
NEW_LINK_PREFIX='        <p><a href="'
NEW_LINK_SUFFIX='</a></p>'
# -------------------

echo "Starting index.html configuration script..."

# Check if index.html exists
if [ ! -f "$INDEX_HTML_PATH" ]; then
    echo "Error: index.html not found at $INDEX_HTML_PATH. Exiting."
    exit 1
fi

# Check if content base directory exists
if [ ! -d "$CONTENT_BASE_DIR" ]; then
    echo "Error: Content base directory not found at $CONTENT_BASE_DIR. Exiting."
    exit 1
fi

# Ensure WEB_ROOT_FOR_CONTENT starts and ends with a slash if it's not empty
if [ -n "$WEB_ROOT_FOR_CONTENT" ] && [[ "$WEB_ROOT_FOR_CONTENT" != /* ]]; then
    WEB_ROOT_FOR_CONTENT="/$WEB_ROOT_FOR_CONTENT"
fi
if [ -n "$WEB_ROOT_FOR_CONTENT" ] && [[ "$WEB_ROOT_FOR_CONTENT" != */ ]]; then
    WEB_ROOT_FOR_CONTENT="$WEB_ROOT_FOR_CONTENT/"
fi


# Create a temporary file for the new index.html content
TEMP_INDEX_HTML=$(mktemp)

# Read the original index.html line by line
IFS=$'\n' # Set Internal Field Separator to newline to handle spaces in lines
IN_LINK_SECTION=false # Initialize flag
HAS_ADDED_NEW_LINKS=false # Flag to ensure new links are only added once per section

while read -r line || [[ -n "$line" ]]; do
    # Check if we are starting the link section
    if [[ "$line" == *"$LINK_SECTION_START"* ]]; then
        echo "$line" >> "$TEMP_INDEX_HTML"
        IN_LINK_SECTION=true
        HAS_ADDED_NEW_LINKS=false # Reset for each link section found (though usually there's only one)
        continue # Skip to the next line after printing the start tag
    fi

    # If we are inside the link section
    if [[ "$IN_LINK_SECTION" == true ]]; then
        # If we hit the end of the link section
        if [[ "$line" == *"$LINK_SECTION_END"* ]]; then
            # We are at the end of the link section.
            # If new links haven't been added yet (meaning the section was empty or we're processing an existing one)
            # This logic ensures new links are inserted right before the closing tag of the section.
            if [ "$HAS_ADDED_NEW_LINKS" == false ]; then
                # Find all directories under CONTENT_BASE_DIR
                for dir in "$CONTENT_BASE_DIR"/*/; do
                    if [ -d "$dir" ]; then
                        DIR_NAME=$(basename "$dir")
                        MAIN_HTML_PATH="${dir}main.html"

                        # Check if main.html exists in the new directory
                        if [ -f "$MAIN_HTML_PATH" ]; then
                            HTML_LINK_TARGET="${WEB_ROOT_FOR_CONTENT}${DIR_NAME}/main.html"
                            LINK_TEXT="Utilization for ${DIR_NAME//_/ }" 

                            # Check if this exact link already exists in the original index.html
                            if ! grep -q "href=\"${HTML_LINK_TARGET}\"" "$INDEX_HTML_PATH"; then
                                echo "Found new content in '$DIR_NAME'. Adding link to index.html."
                                echo "$NEW_LINK_PREFIX$HTML_LINK_TARGET\">$LINK_TEXT$NEW_LINK_SUFFIX" >> "$TEMP_INDEX_HTML"
                            else
                                echo "Link for '$DIR_NAME' already exists. Skipping addition."
                            fi
                        else
                            echo "Directory '$DIR_NAME' found, but no main.html inside. Skipping."
                        fi
                    fi
                done
                HAS_ADDED_NEW_LINKS=true # Mark that new links have been processed for this section
            fi
            
            echo "$line" >> "$TEMP_INDEX_HTML" # Print the closing tag
            IN_LINK_SECTION=false # Exit link section mode
            continue # Skip to the next line
        fi
        
        # If we are inside the link section, but not at the start or end,
        # these are existing links, so we print them to the temporary file.
        echo "$line" >> "$TEMP_INDEX_HTML"
        continue # Skip to the next line
    fi
    
    # For all other lines outside the link section, just copy them as is
    echo "$line" >> "$TEMP_INDEX_HTML"

done < "$INDEX_HTML_PATH"

# Replace the original index.html with the new one
mv "$TEMP_INDEX_HTML" "$INDEX_HTML_PATH"

echo "index.html updated successfully at $INDEX_HTML_PATH"
