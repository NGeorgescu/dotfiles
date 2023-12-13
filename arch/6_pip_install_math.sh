#!/bin/bash

export WORKON_HOME=~/.virtualenvs
source /usr/bin/virtualenvwrapper.sh
workon math
pip install -U -r pip_packages.txt

