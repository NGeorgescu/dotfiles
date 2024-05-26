#!/bin/bash

export WORKON_HOME=~/.virtualenvs

check_venv_exists() {
    [ -d "$WORKON_HOME/math" ]
}

check_venv_active() {
    [ "$VIRTUAL_ENV" == "$WORKON_HOME/math" ]
}

# Activate the virtual environment if it exists
if check_venv_exists; then
    if ! check_venv_active; then
        source /usr/bin/virtualenvwrapper.sh
        workon math
    fi
else
    echo "Virtual environment 'math' not found."
    exit 1
fi

PIP_PACKAGES_FILE="pip_packages.txt"
DEFAULT_SELECTION=""

show_help() {
    cat << EOF
Usage: ${0##*/} [-n|--none] [--help]

Options:
  -n, --none      Deselect all packages by default.
      --help      Display this help and exit.

This script allows you to select and install Python packages listed in a file
using a dialog-based interface. The file format should include categories and
deselected packages:

File format example:

#%% category_name
package1
package2
# package3  # deselected by default

EOF
}

# Check if dialog is installed
if ! command -v dialog &> /dev/null; then
    echo "dialog is required but not installed. Please install it and try again."
    exit 1
fi

# Parse command-line options
options=$(getopt -o nh --long none,help -- "$@")
eval set -- "$options"
while true; do
    case "$1" in
        -n|--none)
            DEFAULT_SELECTION="off"
            shift
            ;;
        --help)
            show_help
            exit 0
            ;;
        --)
            shift
            break
            ;;
    esac
done

# Function to read packages from file
read_packages() {
    packages=()
    current_tag=""
    while IFS= read -r line; do
        # Ignore blank lines
        [[ -z "$line" ]] && continue
        # Handle category lines starting with #%%
        if [[ "$line" =~ ^#%% ]]; then
            current_tag="${line/#\#%% /}"
            continue
        fi
        # Handle deselected packages
        if [[ "$line" =~ ^# ]]; then
            package_name="${line/#\# /}"
            packages+=("${package_name}" "$current_tag" off)
        else
            package_name="$line"
            if [[ "$DEFAULT_SELECTION" == "off" ]]; then
                packages+=("$package_name" "$current_tag" off)
            else
                packages+=("$package_name" "$current_tag" on)
            fi
        fi
    done < "$PIP_PACKAGES_FILE"
}

# Function to filter out already installed packages
filter_installed_packages() {
    installed_packages=$(pip list --format=freeze | cut -d= -f1)
    available_packages=()
    for ((i=0; i<${#packages[@]}; i+=3)); do
        package_name="${packages[i]}"
        if ! echo "$installed_packages" | grep -qw "$package_name"; then
            available_packages+=("${packages[i]}" "${packages[i+1]}" "${packages[i+2]}")
        fi
    done
    packages=("${available_packages[@]}")
}

# Function to display and select packages
select_packages() {
    selected=$(dialog --stdout --separate-output --checklist "Select packages to install:" 0 0 0 "${packages[@]}")
    clear
    if [ -z "$selected" ]; then
        echo "No packages selected. Exiting."
        exit 0
    fi
}

# Function to install selected packages
install_packages() {
    for package in $selected; do
        echo "Installing $package..."
        pip install "$package" | grep -v "Requirement already satisfied"
    done
}

# Read packages from the file
read_packages

# Filter out already installed packages
filter_installed_packages

# Prompt user to select packages
select_packages

# Install selected packages
install_packages

echo "Installation complete."

