#! /bin/bash

# check if calling script has set $base
if [ $# -eq 0 ]; then
  script_dir=`dirname "$0"`
  base=$script_dir/../..
else
  base=$1
fi;

scripts=$base/scripts

model_name="ensemble"
model_paths="$base/models/baseline $base/models/baseline_2 $base/models/baseline_3 $base/models/baseline_4 $base/models/baseline_5"

corpora="dev test"

batch_size=16

. $scripts/translate_generic.sh
