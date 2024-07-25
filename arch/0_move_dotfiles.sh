#!/bin/bash

DESTINATION="$HOME"

find . -maxdepth 1 -name '.*' ! -name '.' ! -name '..' -exec mv -i {} "$DESTINATION" \;

echo "Hidden files and folders have been moved to $DESTINATION"

