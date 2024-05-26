#!/bin/bash

check_venv_exists() {
    [ -d "$WORKON_HOME/math" ]
}

check_venv_active() {
    [ "$VIRTUAL_ENV" == "$WORKON_HOME/math" ]
}

if check_venv_exists; then
    if ! check_venv_active; then
    	echo "Virtual environment 'math' already exists."
    else
        echo "Virtual environment 'math' is already active."
    fi
else
    echo "No virtual environment 'math' found."
fi

echo "Install ML packages? [c/g/N] (CPU, GPU, or none)"
read -r choice

install_cpu() {
    pip install -U torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu
    pip install -U tensorflow-cpu
}

install_gpu() {
    pip install -U torch torchvision torchaudio tensorflow
}

if check_venv_exists; then
    if ! check_venv_active; then
        source /usr/bin/virtualenvwrapper.sh
        workon math
    fi
    pip install -U numpy pip
else
    echo "Creating and activating virtual environment 'math'."
    export WORKON_HOME=~/.virtualenvs
    source /usr/bin/virtualenvwrapper.sh
    mkvirtualenv math
    workon math
    pip install -U numpy pip
fi

case "$choice" in
    c)
        install_cpu
        ;;
    g)
        install_gpu
        ;;
    *)
        echo "No packages will be installed."
        ;;
esac

