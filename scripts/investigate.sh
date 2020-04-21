#! /bin/bash

scripts=`dirname "$0"`
base=$scripts/..

models=$base/models

python $scripts/investigate.py --models $models
