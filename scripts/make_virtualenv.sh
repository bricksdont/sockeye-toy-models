#! /bin/bash

# virtualenv must be installed on your system, install with e.g.
# pip install virtualenv

echo "Executing: pyenv local 3.6.12"

pyenv local 3.6.12

# calling script needs to set:
# $base

mkdir -p $base/venvs

# python3 needs to be installed on your system

virtualenv -p python3 $base/venvs/sockeye3-gpu

# 1 = Sockeye version 1 for autopilot feature (sockeye==1.18.115)

virtualenv -p python3 $base/venvs/sockeye-autopilot

virtualenv -p python3 $base/venvs/sockeye3-cpu
