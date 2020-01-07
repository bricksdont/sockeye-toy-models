#! /bin/bash

src=en
trg=de

data=$base/data
translations=$base/translations

bleu=$base/bleu
mkdir -p $bleu

mkdir -p $bleu/$model_name

for corpus in dev test; do

    # compute case-sensitive BLEU on detokenized data

    cat $translations/$model_name/$corpus.$model_name.$trg | sacrebleu $data/$corpus.$trg > $bleu/$model_name/$corpus.$model_name.bleu

    echo "$bleu/$model_name/$corpus.$model_name.bleu"
    cat $bleu/$model_name/$corpus.$model_name.bleu

done
