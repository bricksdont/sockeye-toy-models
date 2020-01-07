#! /bin/bash

script_dir=`dirname "$0"`
base=$script_dir/..
scripts=$base/scripts
models=$base/models
translations=$base/translations

for model_name in single ensemble; do

    echo "###################################################"

    if [[ -d $base/translations/$model_name ]]; then
      echo "Translations exist: $base/translations/$model_name"
      if [[ -d $base/bleu/$model_name ]]; then
        echo "BLEU scores exist: $base/bleu/$model_name"
        echo "Will skip!"
      else
        . $scripts/evaluate_generic.sh
      fi
    else
      echo "Translations do not exist: $base/translations/$model_name"
    fi
done
