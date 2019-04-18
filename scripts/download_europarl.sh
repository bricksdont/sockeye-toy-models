#! /bin/bash

wget http://www.statmt.org/europarl/v9/training/europarl-v9.de-en.tsv.gz

gunzip europarl-v9.de-en.tsv.gz

cat europarl-v9.de-en.tsv | shuf > europarl-v9.de-en.shuffled.tsv

cut -f 1 europarl-v9.de-en.shuffled.tsv > europarl.de
cut -f 2 europarl-v9.de-en.shuffled.tsv > europarl.en
