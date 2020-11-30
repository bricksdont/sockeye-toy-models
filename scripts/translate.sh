#! /bin/bash

# calling process needs to set:
# base
# $src
# $trg

data=$base/data
scripts=$base/scripts
translations=$base/translations

mkdir -p $translations

source $base/venvs/sockeye3/bin/activate

for seed in 1 2; do

    model_name="baseline_$seed"
    models_sub=$base/models/$model_name

    # fail with non-zero status if there is no model checkpoint,
    # to signal to downstream dependencies that they cannot be satisfied

    if [[ ! -e $models_sub/params.best ]]; then
        echo "There is no single model checkpoint, file does not exist:"
        echo "$models_sub/params.best"
        exit 1
    fi

    translations_sub=$translations/$model_name

    mkdir -p $translations_sub

    input=$data/test.bpe.$src
    output_bpe=$translations_sub/test.bpe.$trg
    output_tokenized=$translations_sub/test.tok.$trg
    output=$translations_sub/test.$trg

    . $scripts/translate_generic.sh

done
