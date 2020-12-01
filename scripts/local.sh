#! /bin/bash

scripts=`dirname "$0"`
base=$(readlink -m $scripts/..)


bash $scripts/all.sh $base
