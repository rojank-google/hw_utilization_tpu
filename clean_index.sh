#!/bin/bash

# --- Configuration (MUST match your index_config.sh settings) ---
INDEX_HTML_PATH="/home/rojank/hw_utilization_tpu/index.html" 
CONTENT_BASE_DIR="/home/rojank/hw_utilization_tpu/webpage_content/z1"

# These must match the format generated by index_config.sh
WEB_ROOT_FOR_CONTENT_REGEX="/hw_utilization_tpu/webpage_content/z1/" 
LINK_SECTION_START_REGEX='<div class="link-section">'
LINK_SECTION_END_REGEX='</div>'

# Regex components for extracting directory name from the link HTML
# Flexible for leading spaces (standard or non-breaking)
LINK_HTML_PREFIX_REGEX='^[[:space:]\xc2\xa0]*<p><a href="' 
LINK_HTML_SUFFIX_REGEX='</a></p>' # Actual literal string match

# Full regex pattern to capture the directory name from a link line
# This pattern will be used with grep to find the directory name
# The (.*?) is a non-greedy match for the link text.
# The `\(` and `\)` are for grep's ERE (Extended Regular Expression) capture group.
# The `\s*` is for any whitespace.
# It uses the path structure (WEB_ROOT_FOR_CONTENT_REGEX)([^/]+)/main\.html">(.+?)<\/a><\/p>
# Capture group 1: directory name (e.g., ALL_feb_to_apr_2025)
# Capture group 2: link text (e.g., Utilization for ALL feb to apr 2025)
LINK_EXTRACT_GREP_REGEX="^s*<p><a href=\"${WEB_ROOT_FOR_CONTENT_REGEX}([^/]+)/main\.html\">.*?<\\/a><\\/p>"

# ---------------------------------------------------------------

echo "Starting index.html cleanup script (Restructured Logic)..."

# --- Phase 1: Collect Existing Directory Names from Filesystem ---
declare -A existing_dirs_on_disk # Using an associative array for quick lookup
echo "Phase 1: Collecting existing content directories from '$CONTENT_BASE_DIR'..."

if [ ! -d "$CONTENT_BASE_DIR" ]; then
    echo "Warning: Content base directory '$CONTENT_BASE_DIR' not found. No directories to check."
    # If the base content dir doesn't exist, we assume no links should be kept
    # and proceed to clear the link section if it exists.
fi

if [ -d "$CONTENT_BASE_DIR" ]; then
    for dir in "$CONTENT_BASE_DIR"/*/; do
        if [ -d "$dir" ]; then
            DIR_NAME=$(basename "$dir")
            existing_dirs_on_disk["$DIR_NAME"]=1 # Store the basename in the associative array
            echo "  Found existing directory on disk: '$DIR_NAME'"
        fi
    done
fi

echo "Phase 1 Complete. Found ${#existing_dirs_on_disk[@]} existing directories."

# --- Phase 2: Filter Links from index.html based on existing directories ---
TEMP_INDEX_HTML=$(mktemp)
LINK_REMOVED_COUNT=0
IN_LINK_SECTION=false
FOUND_LINK_SECTION=false # Flag to ensure we only process the *first* link section

echo "Phase 2: Filtering links in '$INDEX_HTML_PATH'..."

if [ ! -f "$INDEX_HTML_PATH" ]; then
    echo "Error: index.html not found at '$INDEX_HTML_PATH'. Cannot filter links. Exiting."
    rm -f "$TEMP_INDEX_HTML"
    exit 1
fi

while IFS=$'\n' read -r line || [[ -n "$line" ]]; do
    if [[ "$line" == *"$LINK_SECTION_START_REGEX"* ]] && [ "$FOUND_LINK_SECTION" = false ]; then
        IN_LINK_SECTION=true
        FOUND_LINK_SECTION=true
        echo "  Detected start of link section."
        echo "$line" >> "$TEMP_INDEX_HTML"
        continue
    fi

    if [[ "$IN_LINK_SECTION" = true ]]; then
        if [[ "$line" == *"$LINK_SECTION_END_REGEX"* ]]; then
            IN_LINK_SECTION=false
            echo "  Detected end of link section."
            echo "$line" >> "$TEMP_INDEX_HTML"
            continue
        fi

        # This is a link line within the section. Try to extract its directory name.
        # We need a robust regex to extract the directory name from the href attribute.
        # This part requires careful escaping of slashes for grep -E.
        # The pattern looks for the full <p><a href="...">...</a></p> structure.
        
        # Escaping for grep's ERE (Extended Regular Expression)
        # Using a pattern similar to the one that *did* match the lines previously
        # The first `()` will capture the directory name.
        # The `.*?` will capture the link text (non-greedily).
        
        # Removed `^[[:space:]\xc2\xa0]*` from the grep pattern as `\s*` handles it implicitly for ERE,
        # but for robustness let's stick to what we know works for literal matching.
        # Let's rebuild the regex pattern specifically for grep -E:
        
        # Escape fixed parts of the URL for regex.
        escaped_web_root_for_grep=$(printf '%s' "$WEB_ROOT_FOR_CONTENT_REGEX" | sed -E 's/[][\/.^$*+?(){}|-]/\\&/g')
        escaped_link_prefix_for_grep=$(printf '%s' "$NEW_LINK_PREFIX_RAW" | sed -E 's/[][\/.^$*+?(){}|-]/\\&/g')
        escaped_link_suffix_for_grep=$(printf '%s' "$NEW_LINK_SUFFIX_RAW" | sed -E 's/[][\/.^$*+?(){}|-]/\\&/g')

        # The full regex for `grep -E -o` to extract the DIR_NAME
        # We target the `([^/]+)` capture group.
        # NOTE: `grep -oP` with Perl regexes would be easier for non-greedy matching, but `grep -E` is more standard.
        # With `grep -E`, `.*` is greedy. We need to be careful with the trailing part.
        
        # Let's simplify and directly capture the DIR_NAME from the known format:
        # We use a pattern that matches the full link line structure.
        # The `([^/]+)` is the capture group for the directory name.
        # The `.*?` is for the link text (non-greedy).
        
        # The actual regex for `grep -oE` should capture just the directory name.
        # We need to construct a pattern that when matched against the line,
        # its *first* capture group `\1` is the directory name.
        
        # Using a more robust sed pattern for extraction, as grep -oE with complex groups can be tricky
        extracted_dir_name=$(echo "$line" | sed -E "s/^[[:space:]\xc2\xa0]*<p><a href=\"${escaped_web_root_for_grep}([^/]+)\/main\.html\">.*<\\/a><\\/p>$/\1/")
        
        # Check if sed successfully extracted a directory name (i.e., if it matched the pattern)
        if [ "$extracted_dir_name" != "$line" ] && [ -n "$extracted_dir_name" ]; then
            echo "  Extracted directory name from link: '$extracted_dir_name'"
            
            if [ -n "${existing_dirs_on_disk[$extracted_dir_name]}" ]; then
                echo "  Directory '$extracted_dir_name' EXISTS on disk. Keeping link."
                echo "$line" >> "$TEMP_INDEX_HTML"
            else
                echo "  Directory '$extracted_dir_name' is MISSING on disk. Removing link."
                LINK_REMOVED_COUNT=$((LINK_REMOVED_COUNT + 1))
            fi
        else
            # This line is in the link section but didn't match our link pattern.
            # It could be the header/footer of the link section, or another element.
            # Write it back to maintain structure unless it's a blank line etc.
            echo "  Line did not match link pattern or extraction failed. Keeping line to preserve structure."
            echo "$line" >> "$TEMP_INDEX_HTML"
        fi
    else
        # Not in the link section, just copy the line
        echo "$line" >> "$TEMP_INDEX_HTML"
    fi
done < "$INDEX_HTML_PATH"

echo "Phase 2 Complete. $LINK_REMOVED_COUNT links removed."

# --- Phase 3: Replace original index.html with the filtered version ---
echo "Phase 3: Updating '$INDEX_HTML_PATH'..."
if [ "$LINK_REMOVED_COUNT" -gt 0 ] || [ ! -s "$TEMP_INDEX_HTML" ]; then
    # Only replace if changes were made or if temp file ended up empty unexpectedly
    mv "$TEMP_INDEX_HTML" "$INDEX_HTML_PATH"
    echo "index.html updated successfully at '$INDEX_HTML_PATH'."
else
    echo "No changes needed for index.html. Retaining original file."
    rm -f "$TEMP_INDEX_HTML"
fi

echo "Index cleanup script finished."
