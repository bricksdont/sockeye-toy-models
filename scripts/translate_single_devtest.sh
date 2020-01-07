#! /bin/bash

# check if calling script has set $base
if [ $# -eq 0 ]; then
  script_dir=`dirname "$0"`
  base=$script_dir/../..
else
  base=$1
fi;

scripts=$base/scripts

model_name=single
model_paths="$base/models/baseline"

batch_size=64

corpora="dev test"

. $scripts/translate_generic.sh
