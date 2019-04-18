
#! /bin/bash

scripts=`dirname "$0"`
base=$scripts/..

data=$base/data

mkdir -p $data

wget http://www.statmt.org/europarl/v9/training/europarl-v9.de-en.tsv.gz -P $data
gunzip $data/europarl-v9.de-en.tsv.gz

cat $data/europarl-v9.de-en.tsv | shuf > $data/europarl-v9.de-en.shuffled.tsv

cut -f 1 $data/europarl-v9.de-en.shuffled.tsv > $data/europarl.de
cut -f 2 $data/europarl-v9.de-en.shuffled.tsv > $data/europarl.en

head -n 1750000 $data/europarl.de > $data/train.de
head -n 1750000 $data/europarl.en > $data/train.en

head -n 1752000 $data/europarl.de | tail -n 2000 > $data/dev.de
head -n 1752000 $data/europarl.en | tail -n 2000 > $data/dev.en

head -n 1754000 $data/europarl.de | tail -n 2000 > $data/test.de
head -n 1754000 $data/europarl.en | tail -n 2000 > $data/test.en

# sizes
echo "Sizes of corpora:"
for corpus in train dev test; do
	echo "corpus: "$corpus
	wc -l $data/$corpus.de $data/$corpus.en
done

# sanity checks
echo "At this point, please make sure that 1) number of lines are as expected, 2) language suffixes are correct and 3) files are parallel"
