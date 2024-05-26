#!/bin/bash

PIP_PACKAGES_FILE="pip_packages.txt"

# Check if dialog is installed
if ! command -v dialog &> /dev/null; then
    echo "dialog is required but not installed. Please install it and try again."
    exit 1
fi

# Function to read packages from file
read_packages() {
    packages=()
    while IFS= read -r line; do
        [[ -z "$line" ]] && continue
        if [[ "$line" =~ ^# ]]; then
            packages+=("${line:1}" "" off)
        else
            packages+=("$line" "" on)
        fi
    done < "$PIP_PACKAGES_FILE"
}

# Function to display and select packages
select_packages() {
    selected=$(dialog --stdout --separate-output --checklist "Select packages to install:" 0 0 0 "${packages[@]}")
    if [ -z "$selected" ]; then
        echo "No packages selected. Exiting."
        exit 0
    fi
    clear
}

# Function to install selected packages
install_packages() {
    for package in $selected; do
        echo "Installing $package..."
        pip install "$package"
    done
}

# Read packages from the file
read_packages

# Prompt user to select packages
select_packages

# Install selected packages
install_packages

