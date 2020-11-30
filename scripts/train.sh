#! /bin/bash

# calling script needs to set:
# $base
# $src
# $trg

models=$base/models

mkdir -p $models

# measure time

SECONDS=0

for seed in 1 2; do

  model_name="baseline_$seed"

  . $scripts/train_generic.sh

done

echo "time taken:"
echo "$SECONDS seconds"
