#!/bin/bash

# --- Configuration ---
INDEX_HTML_PATH="/home/rojank/hw_utilization_tpu/index.html"
CONTENT_BASE_DIR="/home/rojank/hw_utilization_tpu/webpage_content/z1"

# This is the base URL path for your content on GitHub Pages.
WEB_ROOT_FOR_CONTENT="/hw_utilization_tpu/webpage_content/z1/" 

LINK_SECTION_START='<div class="link-section">'
LINK_SECTION_END='</div>'
NEW_LINK_PREFIX='        <p><a href="'
NEW_LINK_SUFFIX='</a></p>'

# --- Configuration for Main.html Button ---
MAIN_HTML_BUTTON_HTML='<div style="text-align: center; margin-top: 30px;"><a href="/index.html" style="display: inline-block; padding: 12px 25px; background-color: #28a745; color: white; text-decoration: none; border-radius: 5px; font-size: 1.1em; transition: background-color 0.3s ease;">Back to Index</a></div>'
# NEW INSERTION POINT: Target the final </body></html> line
MAIN_HTML_INSERT_BEFORE_TAG='</body></html>' 


# Determine the web path for index.html.
INDEX_WEB_PATH="/hw_utilization_tpu" # <--- IMPORTANT: Verify this for your index.html location!
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

# --- Function to add button to main.html ---
add_button_to_main_html() {
    local main_html_file="$1"
    local insert_before_tag="$2" 
    local button_html="$3"
    local index_web_path="$4"

    echo "DEBUG: Attempting to process main.html: $main_html_file"

    # Replace the placeholder in button_html with the actual index_web_path
    local final_button_html="${button_html//href=\"\/index.html\"/href=\"${index_web_path}\"}"

    # Check if the button already exists in the main.html file
    if ! grep -q -E "href=\"(https?:\/\/[^\/]+)?${index_web_path}\".*Back to Index" "$main_html_file"; then
        echo "DEBUG: 'Back to Index' button NOT found in $main_html_file. Proceeding to add."
        
        # Check if the insert_before_tag (</body></html>) exists anywhere in the file
        if grep -q "${insert_before_tag}" "$main_html_file"; then 
            echo "DEBUG: Found insert_before_tag '${insert_before_tag}' in $main_html_file. Preparing for awk."
            
            # Use awk to insert the line *before* the specified tag.
            # The awk pattern is now simply looking for the literal string.
            awk -v tag_string="${insert_before_tag}" -v html_code="${final_button_html}" '
                !inserted_button && index($0, tag_string) { # Using index() for literal substring match
                    print html_code # Print the button HTML first
                    inserted_button = 1
                }
                { print } # Then print the current line (which contains the tag_string)
            ' "$main_html_file" > "${main_html_file}.tmp"
            
            # Check if awk command was successful and the temp file is not empty
            if [ $? -eq 0 ] && [ -s "${main_html_file}.tmp" ]; then 
                echo "DEBUG: awk command successful for $main_html_file. Moving temp file."
                mv "${main_html_file}.tmp" "$main_html_file"
                if [ $? -ne 0 ]; then
                    echo "ERROR: Failed to move ${main_html_file}.tmp to $main_html_file. Check file permissions on the target directory/file."
                fi
            else
                echo "ERROR: awk command failed or created an empty temp file for $main_html_file. Temp file size: $(stat -c%s "${main_html_file}.tmp" 2>/dev/null || echo "N/A")."
                # Clean up temp file if awk failed or if it's empty
                rm -f "${main_html_file}.tmp" 
            fi
        else
            echo "WARNING: Insert tag '${insert_before_tag}' not found in $main_html_file. Button not added. Please check your main.html files for the '</body></html>' tag on one line."
        fi
    else
        echo "DEBUG: 'Back to Index' button ALREADY EXISTS in $main_html_file. Skipping modification."
    fi
}
# -------------------------------------------


# Create a temporary file for the new index.html content
TEMP_INDEX_HTML=$(mktemp)

# Read the original index.html line by line
IFS=$'\n' # Set Internal Field Separator to newline to handle spaces in lines
IN_LINK_SECTION=false 
HAS_ADDED_NEW_LINKS=false 

while read -r line || [[ -n "$line" ]]; do
    # Check if we are starting the link section
    if [[ "$line" == *"$LINK_SECTION_START"* ]]; then
        echo "$line" >> "$TEMP_INDEX_HTML"
        IN_LINK_SECTION=true
        HAS_ADDED_NEW_LINKS=false 
        continue 
    fi

    # If we are inside the link section
    if [[ "$IN_LINK_SECTION" == true ]]; then
        # If we hit the end of the link section
        if [[ "$line" == *"$LINK_SECTION_END"* ]]; then
            if [ "$HAS_ADDED_NEW_LINKS" == false ]; then
                # Find all directories under CONTENT_BASE_DIR
                for dir in "$CONTENT_BASE_DIR"/*/; do
                    if [ -d "$dir" ]; then
                        DIR_NAME=$(basename "$dir")
                        MAIN_HTML_FILE="${dir}main.html" 

                        # Check if main.html exists in the new directory
                        if [ -f "$MAIN_HTML_FILE" ]; then
                            echo "DEBUG: Found main.html: $MAIN_HTML_FILE"
                            HTML_LINK_TARGET="${WEB_ROOT_FOR_CONTENT}${DIR_NAME}/main.html"
                            LINK_TEXT="Utilization for ${DIR_NAME//_/ }" 

                            # Check if this exact link already exists in the original index.html
                            if ! grep -q "href=\"${HTML_LINK_TARGET}\"" "$INDEX_HTML_PATH"; then
                                echo "Found new content in '$DIR_NAME'. Adding link to index.html."
                                echo "$NEW_LINK_PREFIX$HTML_LINK_TARGET\">$LINK_TEXT$NEW_LINK_SUFFIX" >> "$TEMP_INDEX_HTML"
                            else
                                echo "Link for '$DIR_NAME' already exists in index.html. Skipping addition."
                            fi # This 'fi' was missing in the previous version
                            
                            # --- Call the function to add button to this main.html ---
                            add_button_to_main_html "$MAIN_HTML_FILE" "$MAIN_HTML_INSERT_BEFORE_TAG" "$MAIN_HTML_BUTTON_HTML" "$INDEX_WEB_PATH"
                            # --------------------------------------------------------

                        else
                            echo "Directory '$DIR_NAME' found, but no main.html inside. Skipping."
                        fi
                    fi
                done
                HAS_ADDED_NEW_LINKS=true 
            fi
            
            echo "$line" >> "$TEMP_INDEX_HTML" 
            IN_LINK_SECTION=false 
            continue 
        fi
        
        echo "$line" >> "$TEMP_INDEX_HTML"
        continue 
    fi
    
    echo "$line" >> "$TEMP_INDEX_HTML"

done < "$INDEX_HTML_PATH"

# Replace the original index.html with the new one
mv "$TEMP_INDEX_HTML" "$INDEX_HTML_PATH"

echo "index.html updated successfully at $INDEX_HTML_PATH"
