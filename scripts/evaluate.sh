#! /bin/bash

# calling process needs to set:
# base
# $src
# $trg

data=$base/data
scripts=$base/scripts
translations=$base/translations
evaluations=$base/evaluations

mkdir -p $evaluations

source $base/venvs/sockeye3-cpu/bin/activate

for seed in 1 2; do

    model_name="baseline_$seed"
    models_sub=$base/models/$model_name

    evaluations_sub=$evaluations/$model_name

    mkdir -p $evaluations_sub

    hyp=$evaluations_sub/test.$trg
    ref=$data/test.$trg
    output=$evaluations_sub/bleu

    . $scripts/evaluate_generic.sh

done
