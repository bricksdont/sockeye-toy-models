#! /bin/bash

# S3IT
source /net/cephfs/home/mathmu/scratch/goeckeritz-model/venvs/sockeye3-cpu/bin/activate

# work around slurm placing scripts in var folder
base=/net/cephfs/home/mathmu/scratch/goeckeritz-model

data=$base/data

mkdir -p $data

sockeye-autopilot --task wmt14_en_de --model none --workspace $base/sockeye_autopilot

# sizes
echo "Sizes of corpora:"
for corpus in train dev test; do
	echo "corpus: "$corpus
	wc -l $data/$corpus.de $data/$corpus.en
done

# sanity checks
echo "At this point, please make sure that 1) number of lines are as expected, 2) language suffixes are correct and 3) files are parallel"

