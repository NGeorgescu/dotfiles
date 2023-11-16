#!/bin/bash

# Define the destination directory as the home directory
DESTINATION="$HOME"

# Move all hidden files and folders from the current directory to the destination
# without overwriting existing files in the destination
find . -maxdepth 1 -name '.*' -exec mv -i {} "$DESTINATION" \;

echo "Hidden files and folders have been moved to $DESTINATION"

