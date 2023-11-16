#!/bin/bash

export WORKON_HOME=~/.virtualenvs
source /usr/bin/virtualenvwrapper.sh
mkcirtualenv math
workon math
pip install -U numpy
pip install -U torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu
pip install -U tensorflow-cpu
pip install -U $(cat pip_packages.txt)

